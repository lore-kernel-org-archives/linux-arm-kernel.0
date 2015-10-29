From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu, 29 Oct 2015 22:39:24 +0100
Subject: [PATCH] ARM: dts: rockchip: Setup ethernet0 alias for u-boot
In-Reply-To: <1895461.b5NitQ7UFH@phil>
References: <1446151497-29833-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1895461.b5NitQ7UFH@phil>
Message-ID: <1446154764.4092.273.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-10-29 at 21:52 +0100, Heiko Stuebner wrote:
> Hi Sjoerd,
> 
> Am Donnerstag, 29. Oktober 2015, 21:44:57 schrieb Sjoerd Simons:
> > Add an ethernet0 alias for the wired network card and an all 0
> > default
> > mac address so that u-boot can find the device-node and fill in the
> > mac address.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> > 
> > ?arch/arm/boot/dts/rk3288-rock2-square.dts | 6 ++++++
> > ?1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts
> > b/arch/arm/boot/dts/rk3288-rock2-square.dts
> > index 0ef065d..a029ebf 100644
> > --- a/arch/arm/boot/dts/rk3288-rock2-square.dts
> > +++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
> > @@ -45,6 +45,10 @@
> > ?	model = "Radxa Rock 2 Square";
> > ?	compatible = "radxa,rock2-square", "rockchip,rk3288";
> > ?
> > +	aliases {
> > +		ethernet0 = &gmac;
> > +	};
> > +
> 
> wouldn't it make more sense to have this in the rk3288.dtsi, so to
> keep
> every board from having to add this alias?

Hmm, that would work. Thought it would add an alias point to a disabled
node for boards that don't have a wired interface. If that isn't an
issue it can indeed be moved there.
> 
> > ?	chosen {
> > ?		stdout-path = "serial2:115200n8";
> > ?	};
> > @@ -130,6 +134,8 @@
> > ?};
> > ?
> > ?&gmac {
> > +	/* To be filled in by U-Boot */
> > +	mac-address = [00 00 00 00 00 00];
> > ?	status = "ok";
> > ?};
> 
> I guess the same applies for the mac placeholder.

In any case they should be in the same dts{i}.

--?
Sjoerd Simons
Collabora Ltd.
