From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 11 Sep 2012 11:26:44 +0200
Subject: [PATCH v2 1/3] arm/dts: Add twl6030-usb data
In-Reply-To: <1347345381-4390-2-git-send-email-kishon@ti.com>
References: <1347345381-4390-1-git-send-email-kishon@ti.com>
 <1347345381-4390-2-git-send-email-kishon@ti.com>
Message-ID: <504F03D4.5080800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 08:36 AM, Kishon Vijay Abraham I wrote:
> Add twl6030-usb data node in twl6030 device tree file
> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/omap4-panda.dts |    4 ++++
>  arch/arm/boot/dts/omap4-sdp.dts   |    4 ++++
>  arch/arm/boot/dts/twl6030.dtsi    |    5 +++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index 9880c12..2999eba 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -126,3 +126,7 @@
>  	ti,non-removable;
>  	bus-width = <4>;
>  };
> +
> +&twlusb {
> +	usb-supply = <&vusb>;
> +};
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index 72216e9..d8290c0 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -226,3 +226,7 @@
>  	bus-width = <4>;
>  	ti,non-removable;
>  };
> +
> +&twlusb {
> +	usb-supply = <&vusb>;
> +};
> diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
> index 3b2f351..8e3aac9 100644
> --- a/arch/arm/boot/dts/twl6030.dtsi
> +++ b/arch/arm/boot/dts/twl6030.dtsi
> @@ -83,4 +83,9 @@
>  	clk32kg: regulator at 12 {
>  		compatible = "ti,twl6030-clk32kg";
>  	};
> +
> +	twlusb: twl6030-usb {

That name should be a generic device class name is possible.
What is twl6030-usb exactly? an USB PHY?

> +		compatible = "ti,twl6030-usb";
> +		interrupts = < 4 10 >;

If this is for two interrupts, you'd better split them to avoid
confusion with irq specifiers that requires several attributes like for
the GIC.

+		interrupts = <4>, <10>; /* IRQ1 blabla, IRQ2 blabla*/

The comments are not mandatory assuming the binding is documented.

Regards,
Benoit
