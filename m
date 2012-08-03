From: balbi@ti.com (Felipe Balbi)
Date: Fri, 3 Aug 2012 16:31:43 +0300
Subject: [PATCH v6 06/11] arm/dts: Add twl6030-usb data
In-Reply-To: <1343639400-28725-7-git-send-email-kishon@ti.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-7-git-send-email-kishon@ti.com>
Message-ID: <20120803133142.GH8269@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 30, 2012 at 02:39:55PM +0530, Kishon Vijay Abraham I wrote:
> Add twl6030-usb data node in twl6030 device tree file
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/omap4-panda.dts |    4 ++++
>  arch/arm/boot/dts/omap4-sdp.dts   |    4 ++++
>  arch/arm/boot/dts/twl6030.dtsi    |    5 +++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index 1efe0c5..7052422 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -89,3 +89,7 @@
>  	ti,non-removable;
>  	bus-width = <4>;
>  };
> +
> +&twlusb {
> +	usb-supply = <&vusb>;
> +};
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index d08c4d1..6326d7c 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -158,3 +158,7 @@
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
> +		compatible = "ti,twl6030-usb";
> +		interrupts = < 4 10 >;
> +	};
>  };
> -- 
> 1.7.9.5
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120803/fc9608a7/attachment.sig>
