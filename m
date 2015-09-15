From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 15 Sep 2015 09:45:16 +0300
Subject: [PATCH v2 11/23] ARM/dmaengine: edma: Merge the two drivers under
 drivers/dmaengine
In-Reply-To: <20150914161233.GL4215@atomide.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
 <1441974442-8233-12-git-send-email-peter.ujfalusi@ti.com>
 <20150914161233.GL4215@atomide.com>
Message-ID: <55F7BE7C.1080703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2015 07:12 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [150911 05:35]:
>> Move the code out from arch/arm/common and merge it inside of the dmaengine
>> driver.
>> This change is done with as minimal change to the code as possible to avoid
>> any possibilities to introducing regression.
> 
> You should check your git config so it uses -M option to git diff
> to detect renames.

I'm moving the code form arch/arm/common/edma.c inside of the already existing
drivers/dma/edma.c
The diff looks the same with -M or -C since during the code move most line
needed to be changed (struct edma -> struct edma_cc). But the merge itself
does not change how the code works at this point.

> Anyways, assuming you're just moving code, for
> the omap parts:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks,
P?ter
