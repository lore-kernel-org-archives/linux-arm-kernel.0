From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 15:31:26 +0200
Subject: [linux-sunxi] Re: [PATCH v4 1/4] clk: sunxi-ng: Enable DE2_CCU
 for SUN8I and SUN50I
In-Reply-To: <2955967.qdhifWMYUT@jernej-laptop>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180905070335.dclhpxjld4vdkdu4@flea>
 <2955967.qdhifWMYUT@jernej-laptop>
Message-ID: <20180907133125.ghks5cgk5u6vrhd6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 07:10:06AM +0200, Jernej ?krabec wrote:
> Dne sreda, 05. september 2018 ob 09:03:35 CEST je Maxime Ripard napisal(a):
> > On Tue, Sep 04, 2018 at 10:06:06PM +0530, Jagan Teki wrote:
> > > Allwinner SoC like SUN8I and SUN50I has DE2 CCU so enable them
> > > as default.
> > > 
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v4, v3:
> > > - none
> > > Changes for v2:
> > > - Enable for MACH_SUN8I
> > > 
> > >  drivers/clk/sunxi-ng/Kconfig | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> > > index 826674d090fd..e20182aa9748 100644
> > > --- a/drivers/clk/sunxi-ng/Kconfig
> > > +++ b/drivers/clk/sunxi-ng/Kconfig
> > > @@ -63,6 +63,8 @@ config SUN8I_V3S_CCU
> > > 
> > >  config SUN8I_DE2_CCU
> > >  
> > >  	bool "Support for the Allwinner SoCs DE2 CCU"
> > > 
> > > +	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> > > +	depends on DRM_SUN4I && (MACH_SUN8I || (ARM64 && ARCH_SUNXI))
> > 
> > I don't see why there's a dependency on the DRM driver. I'm pretty
> > sure this would even break simplefb.
> 
> I think best approach would be that SUN8I_MIXER selects (or depends on?) this 
> symbol, since it can't work if there is no DE2 CCU clock present.

This is a runtime dependency, not a build time one. We're not doing it
for any other similar driver, so there's no reason to do it in this
particular case.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/abb38502/attachment.sig>
