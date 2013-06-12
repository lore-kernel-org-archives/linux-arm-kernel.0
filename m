From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 13:31:18 +0200
Subject: [PATCHv4 4/9] i2c: mv64xxx: Add Allwinner sun4i compatible
In-Reply-To: <20130612105613.GT16502@lunn.ch>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-5-git-send-email-maxime.ripard@free-electrons.com>
 <20130612105613.GT16502@lunn.ch>
Message-ID: <20130612113118.GF16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 12:56:13PM +0200, Andrew Lunn wrote:
> On Wed, Jun 12, 2013 at 10:07:13AM +0200, Maxime Ripard wrote:
> > Add the compatible string for the Allwinner A10 i2c controller and the
> > associated register layout.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/i2c/busses/Kconfig       |  3 ++-
> >  drivers/i2c/busses/i2c-mv64xxx.c |  1 +
> >  include/linux/mv643xx_i2c.h      | 10 ++++++++++
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 631736e..5dc4148 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -507,10 +507,11 @@ config I2C_MPC
> >  
> >  config I2C_MV64XXX
> >  	tristate "Marvell mv64xxx I2C Controller"
> > -	depends on (MV64X60 || PLAT_ORION)
> > +	depends on (MV64X60 || PLAT_ORION || ARCH_SUNXI)
> 
> Hi Maxime.
> 
> What about MV64X60? It also needs to pass the registers in its
> platform data.

I grep'ed for the users mv64xxx_i2c_pdata in arch/arm, and the
plat-orion/common.c was the only user. Obviously, I forgot to think
about the PPC architecture.

Anyway, this patch will be dropped.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
