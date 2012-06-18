From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Jun 2012 22:02:23 +0800
Subject: [PATCH 07/16] dma: ipu: remove the use of ipu_platform_data
In-Reply-To: <20120618081943.GA25447@shlinux2.ap.freescale.net>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-8-git-send-email-shawn.guo@linaro.org>
 <20120615093713.GE8383@shlinux2.ap.freescale.net>
 <20120616030106.GD29663@S2101-09.ap.freescale.net>
 <20120618081943.GA25447@shlinux2.ap.freescale.net>
Message-ID: <20120618140219.GE19249@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 04:19:44PM +0800, Dong Aisheng wrote:
> Hmm, i'm wondering it may not make too much sense to alloc_descs without
> using irqdomain since the allocated irqs are all virtual irqs.

It still makes much sense, because we are killing all those static
IRQ_START definitions here, so we need to get irq_base by calling
alloc_descs anyway.

> Using private mapping is not recommended.
> Maybe we can do it together with this patch since irqdomain support
> does not depend on device tree.
> What do you think?
> 
At this point, I would be conservative on that, since I do not have
the setup to test all the IPU irq handling.

-- 
Regards,
Shawn
