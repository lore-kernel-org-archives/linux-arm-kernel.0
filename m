From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Sat, 28 Mar 2015 23:50:08 +0200
Subject: [PATCH 3/5] dmaengine: bcm2835-dma: Fix memory leak when stopping
 a running transfer
In-Reply-To: <551626A5.3080509@wwwdotorg.org>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
 <1427456155-28990-4-git-send-email-peter.ujfalusi@ti.com>
 <551626A5.3080509@wwwdotorg.org>
Message-ID: <55172210.4070900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks,

On 03/28/2015 05:57 AM, Stephen Warren wrote:
> On 03/27/2015 05:35 AM, Peter Ujfalusi wrote:
>> The vd->node is removed from the lists when the transfer started so the
>> vchan_get_all_descriptors() will not find it. This results memory leak.
> 
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> (I'm just assuming the explanation makes sense and is correct; more of a
> not-a-NAK so it doesn't look like a lack of response!)

I can not debug the bcm2835-dma driver, but the exact same pattern existed in
edma and omap-dma driver and they both leaked the edesc in a same predictable
fashion. I just checked the virt-dma users and sent the fixes for the ones
which had the same flow of events.

-- 
P?ter
