From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 16 Dec 2011 14:57:22 +0200
Subject: [PATCHv12 0/9] OMAP3+: PRCM chain handler
In-Reply-To: <alpine.DEB.2.00.1112152207440.12660@utopia.booyaka.com>
References: <20111215213358.26632.44165.stgit@dusk>
 <alpine.DEB.2.00.1112152207440.12660@utopia.booyaka.com>
Message-ID: <1324040242.18394.12.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-12-15 at 22:10 -0700, Paul Walmsley wrote:
> Hi
> 
> This series was boot-tested on a 4430 ES2 Panda also.  It generates the 
> following message on boot:
> 
> PRCM: failed to allocate irq descs: -12
> 
> which is an -ENOMEM coming from irq_alloc_descs().  This is probably 
> because OMAP hasn't been converted to use sparse IRQs yet.

You should be able to enable SPARSE_IRQ from the config and this
probably fixes it, this is what I saw with OMAP4 testing, not sure if it
was enabled on your config.

> Until that happens, this message should be harmless.

Currently I guess it is harmless as we don't have OMAP4 PM support
anyway, so nobody can use the PRCM interrupts on that platform anyway.
The error message itself indicates that PRCM interrupt support does not
work at all.

Other than that, the set looks good to me after your changes.

-Tero
