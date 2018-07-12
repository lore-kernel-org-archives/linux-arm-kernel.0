From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Thu, 12 Jul 2018 20:57:28 -0300
Subject: [PATCH] arm64: dts: rockchip: add USB 2.0 and 3.0 support on
 Ficus board
In-Reply-To: <1807608.jKivtyaJVm@phil>
References: <20180712160008.30972-1-ezequiel@collabora.com>
 <1807608.jKivtyaJVm@phil>
Message-ID: <baed174d43eddb7dba8f3b06444eb6eacee4bf55.camel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-12 at 23:45 +0200, Heiko Stuebner wrote:
> Hi,
> 
> Am Donnerstag, 12. Juli 2018, 18:00:08 CEST schrieb Ezequiel Garcia:
> > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > 
> > The board exposes two types A ports, one is USB 3.0, up to 5.0Gbps and
> > another one is USB 2.0 up to 480Mbps. Enable the USB PHYs and the USB
> > controllers to enable theses devices.
> > 
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> > Heiko,
> > 
> > Enric finally had some time to take a look at the schematics,
> > and help with the USB stuff. Thanks to him, USB host
> > is working now! \o/
> 
> great to hear that
> One issue below though.
> 
> 
> > USB Type-C will have to wait until we have some spare time
> > to debug the fusb302 driver.
> > 
> >  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 85 +++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > index 0d14183dd4a9..d0631c02749c 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > @@ -61,6 +61,16 @@
> >  		vin-supply = <&vcc3v3_sys>;
> >  	};
> >  
> > +	vcc5v0_host: vcc5v0-host-regulator {
> > +		compatible = "regulator-fixed";
> > +		enable-active-high;
> > +		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&host_vbus_drv>;
> > +		regulator-name = "vcc5v0_host";
> > +		regulator-always-on;
> 
> missing voltages and also a vin-supply.

Indeed.

> These 5V don't come from thin air ;-) and I really like
> seeing sane regulator trees.
> 

Oh, right. And vcc3v3_pcie is also missing the min/max voltages,
so I'll add them.

I guess it's better to have these voltage properties -- despite they are
listed as optional.

Thanks for reviewing,
Eze
