From: balbi@ti.com (Felipe Balbi)
Date: Fri, 2 Jan 2015 15:39:17 -0600
Subject: [PATCH] irqchip: omap-intc: improve IRQ handler
In-Reply-To: <20150102213250.GG3298@atomide.com>
References: <1420224433-27001-1-git-send-email-balbi@ti.com>
 <20150102213250.GG3298@atomide.com>
Message-ID: <20150102213917.GH4920@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 02, 2015 at 01:32:51PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150102 10:50]:
> > as it turns out the current IRQ number will
> > *always* be available from SIR register which
> > renders the reads of PENDING registers as plain
> > unnecessary overhead.
> > 
> > In order to catch any situation where SIR reads
> > as zero, we're adding a WARN() to turn it into
> > a very verbose error and users actually report
> > it.
> > 
> > With this patch average running time of
> > omap_intc_handle_irq() reduced from about 28.5us
> > to 19.8us as measured by the kernel function
> > profiler.
> 
> That's a nice improvment for an interrupt controller :)
>  
> > Tested with BeagleBoneBlack Rev A5C.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> > 
> > Before applying, it would be very nice to get reports
> > from other folks on different platforms, specially OMAP2/3
> > ones which I don't have (easy) access.
> 
> Seems to behave just fine on omap2 and 3 here, gave it
> a quick try on n800, n900, omap3-ldp and 37xx-evm:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

cool, thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150102/7b7a07f0/attachment.sig>
