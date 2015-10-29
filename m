From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 29 Oct 2015 23:57:26 +0100
Subject: [PATCH] ARM: dts: rockchip: Setup ethernet0 alias for u-boot
In-Reply-To: <1446154764.4092.273.camel@collabora.co.uk>
References: <1446151497-29833-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1895461.b5NitQ7UFH@phil> <1446154764.4092.273.camel@collabora.co.uk>
Message-ID: <206596798.21b0hzZtSg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 29. Oktober 2015, 22:39:24 schrieb Sjoerd Simons:
> On Thu, 2015-10-29 at 21:52 +0100, Heiko Stuebner wrote:
> > Hi Sjoerd,
> > 
> > Am Donnerstag, 29. Oktober 2015, 21:44:57 schrieb Sjoerd Simons:
> > > Add an ethernet0 alias for the wired network card and an all 0
> > > default
> > > mac address so that u-boot can find the device-node and fill in the
> > > mac address.
> > > 
> > > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > > ---
> > > 
> > >  arch/arm/boot/dts/rk3288-rock2-square.dts | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts
> > > b/arch/arm/boot/dts/rk3288-rock2-square.dts
> > > index 0ef065d..a029ebf 100644
> > > --- a/arch/arm/boot/dts/rk3288-rock2-square.dts
> > > +++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
> > > @@ -45,6 +45,10 @@
> > >  	model = "Radxa Rock 2 Square";
> > >  	compatible = "radxa,rock2-square", "rockchip,rk3288";
> > >  
> > > +	aliases {
> > > +		ethernet0 = &gmac;
> > > +	};
> > > +
> > 
> > wouldn't it make more sense to have this in the rk3288.dtsi, so to
> > keep
> > every board from having to add this alias?
> 
> Hmm, that would work. Thought it would add an alias point to a disabled
> node for boards that don't have a wired interface. If that isn't an
> issue it can indeed be moved there.

we also have aliases for all i2c, mmc, spi, uart etc nodes ... some of
which may stay disabled. But i2c5 stays i2c5 everywhere
and similarly the internal ethernet will stay ethernet0 everywhere too.

And for the "fluffy" good feeling, a lot of other socs also seem to keep their
ethernet0 aliases in the central dtsi (allwinner, freescale, socfpga),
so it's not obviously wrong :-) .


Heiko
