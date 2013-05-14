From: horms@verge.net.au (Simon Horman)
Date: Tue, 14 May 2013 11:40:37 +0900
Subject: [PATCH 2/3] ARM: shmobile: r8a7790: Configure R-Car GPIO for
 IRQ_TYPE_EDGE_BOTH
In-Reply-To: <2257564.fgMO2c8G9k@avalon>
References: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
 <1368435233-8587-3-git-send-email-horms+renesas@verge.net.au>
 <2257564.fgMO2c8G9k@avalon>
Message-ID: <20130514024034.GA20239@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 12:33:42AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 13 May 2013 17:53:52 Simon Horman wrote:
> > "gpio-rcar: Support IRQ_TYPE_EDGE_BOTH" adds support to the R-Car GPIO
> > driver for IRQ_TYPE_EDGE_BOTH. As hardware support for this feature is
> > not universal for all SoCs a flag, has_both_edge_trigger, has been
> > added to the platform data of the driver to allow this feature to be
> > enabled.
> 
> What about moving this information to a platform ID table in the gpio-rcar 
> driver ?

Magnus, do you have an opinion on this?

> > As the r8a7790 SoC hardware supports this feature enable it.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > ---
> > 
> > This patch has a build-time dependency on
> > "gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH".
> > ---
> >  arch/arm/mach-shmobile/setup-r8a7790.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c
> > b/arch/arm/mach-shmobile/setup-r8a7790.c index eeef5f6..b461d93 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> > @@ -45,6 +45,7 @@ static struct gpio_rcar_config
> > r8a7790_gpio##idx##_platform_data = {	\ .irq_base	= 0,						
> \
> >  	.number_of_pins	= 32,						\
> >  	.pctl_name	= "pfc-r8a7790",				\
> > +	.has_both_edge_trigger = 1,					\
> >  };									\
> > 
> >  R8A7790_GPIO(0);
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
