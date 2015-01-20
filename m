From: ipaton0@gmail.com (Iain Paton)
Date: Tue, 20 Jan 2015 17:02:06 +0000
Subject: [linux-sunxi] [PATCH v4 5/5] ARM: sunxi: dts: Add PS2 nodes for
 A20 lime2 board
In-Reply-To: <1421417021-3247-6-git-send-email-vishnupatekar0510@gmail.com>
References: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
 <1421417021-3247-6-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <54BE8A0E.30604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/15 14:03, Vishnu Patekar wrote:
> Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> index ed364d5..3365f12 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -113,6 +113,18 @@
>  			status = "okay";
>  		};
>  
> +		ps20: ps2 at 01c2a000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&ps20_pins_a>;
> +			status = "okay";
> +		};
> +
> +		ps21: ps2 at 01c2a400 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&ps21_pins_a>;
> +			status = "okay";
> +		};
> +
>  		i2c0: i2c at 01c2ac00 {
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2c0_pins_a>;
> 

As the Lime2 doesn't actually have any PS2 connectors on the board, 
I'd prefer that these are not enabled unconditionally. Doing so 
only makes it more difficult for people who want to use these pins 
for other functions.

Device tree overlays seem to be close to being merged, perhaps we 
could leave enabling this to an overlay?
