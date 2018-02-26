From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Feb 2018 09:49:19 +0100
Subject: [PATCH v2 2/4] ARM: dtsi: add pwm node for sun8i.
In-Reply-To: <20180225135134.GA14529@arx-s1>
References: <20180225135134.GA14529@arx-s1>
Message-ID: <20180226084919.wt2yljq3nxr5g2vu@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 25, 2018 at 09:51:34PM +0800, hao_zhang wrote:
> This patch adds pwm node for sun8i.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 173dcc1..99a0261 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -295,6 +295,11 @@
>  				bias-pull-up;
>  			};
>  
> +			pwm_ch0_pin: pwm-ch0-pin {
> +				pins = "PB2";
> +				function = "pwm";
> +			};
> +
>  			uart0_pb_pins: uart0-pb-pins {
>  				pins = "PB22", "PB23";
>  				function = "uart0";
> @@ -306,6 +311,14 @@
>  			reg = <0x01c20c90 0x10>;
>  		};
>  
> +		pwm: pwm at 1c23400 {
> +			     compatible = "allwinner,sun8i-r40-pwm";
> +			     reg = <0x01c23400 0x154>;

The size must be the size of the whole memory block allocated to the
controller, so that would be 0x400 in this case.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/01b8f6e2/attachment-0001.sig>
