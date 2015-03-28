From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Mar 2015 21:57:25 -0600
Subject: [PATCH 3/5] dmaengine: bcm2835-dma: Fix memory leak when stopping
 a running transfer
In-Reply-To: <1427456155-28990-4-git-send-email-peter.ujfalusi@ti.com>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
 <1427456155-28990-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <551626A5.3080509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2015 05:35 AM, Peter Ujfalusi wrote:
> The vd->node is removed from the lists when the transfer started so the
> vchan_get_all_descriptors() will not find it. This results memory leak.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
(I'm just assuming the explanation makes sense and is correct; more of a
not-a-NAK so it doesn't look like a lack of response!)
