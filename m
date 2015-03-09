From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Mar 2015 20:50:09 +0100
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
In-Reply-To: <1425915402-10012-3-git-send-email-eliad@wizery.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <1425915402-10012-3-git-send-email-eliad@wizery.com>
Message-ID: <9217056.Z3urqp19oZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 March 2015 17:36:42 Eliad Peller wrote:
> --- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
> @@ -64,4 +64,13 @@
>         vmmc-supply = <&lbep5clwmc_wlen>;
>         bus-width = <4>;
>         non-removable;
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       wlcore: wlcore at 2 {
> +               compatible = "ti,wl1835";
> +               reg = <2>;
> +               interrupt-parent = <&gpio5>;
> +               interrupts = <8 IRQ_TYPE_NONE>;
> +       };
> 

Why IRQ_TYPE_NONE?

I was expecting you to remove all calls to legacy_init_wl12xx from this file,
including the ones for wl12xx aside from the wl18xx ones you removed, but
if that's enough to clean out the platform_data handling from the wlcore
driver, it's good enough as a start.

	Arnd
