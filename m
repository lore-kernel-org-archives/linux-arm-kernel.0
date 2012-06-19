From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 19 Jun 2012 13:51:15 +0800
Subject: [PATCH 07/16] dma: ipu: remove the use of ipu_platform_data
In-Reply-To: <20120618140219.GE19249@S2101-09.ap.freescale.net>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-8-git-send-email-shawn.guo@linaro.org>
 <20120615093713.GE8383@shlinux2.ap.freescale.net>
 <20120616030106.GD29663@S2101-09.ap.freescale.net>
 <20120618081943.GA25447@shlinux2.ap.freescale.net>
 <20120618140219.GE19249@S2101-09.ap.freescale.net>
Message-ID: <20120619055114.GA10387@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 10:02:23PM +0800, Shawn Guo wrote:
> On Mon, Jun 18, 2012 at 04:19:44PM +0800, Dong Aisheng wrote:
...
> > Using private mapping is not recommended.
> > Maybe we can do it together with this patch since irqdomain support
> > does not depend on device tree.
> > What do you think?
> > 
> At this point, I would be conservative on that, since I do not have
> the setup to test all the IPU irq handling.
> 
I looked into the code a bit more, it seems ipu uses its own special irq mapping
between virt irq and hw/dma_chan irq itself and the mapping is dynamically
and limited to how many CONFIG_MX3_IPU_IRQS defined.
No sure it's so suitable to convert to irqdomain.
With adding irqdomain, i wonder we may need change this mechanism a bit.

For now, i'm ok to put that work in another patch later and using the original
way first since the later patch may need to do more things, so
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
