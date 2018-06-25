From: sean.wang@mediatek.com (Sean Wang)
Date: Mon, 25 Jun 2018 17:17:43 +0800
Subject: [PATCH] [dts] fix green/blue pio-led on bananapi-r2
In-Reply-To: <trinity-0d48bc23-f754-4da3-af01-c3a7abe1d34b-1529682783853@3c-app-gmx-bs42>
References: <trinity-ae29ad25-a4fb-47f3-8d68-f6e58c875a0e-1529682447976@3c-app-gmx-bs42>
 <trinity-0d48bc23-f754-4da3-af01-c3a7abe1d34b-1529682783853@3c-app-gmx-bs42>
Message-ID: <1529918263.29697.31.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-06-22 at 17:53 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> Date: Sun, 17 Jun 2018 19:11:58 +0200
> Subject: [PATCH] [dts] fix green/blue pio-led
>  green/blue pio-leds (near GPIO-Header) are swapped and LOW-active
>  this patch restore this expected behaviour
>  red cannot be switched afaik
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 531d905d924ff..3e8a0ffe8b13e 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -89,21 +89,21 @@
>          pinctrl-names = "default";
>          pinctrl-0 = <&led_pins_a>;
>  
> -        blue {
> -            label = "bpi-r2:pio:blue";
> -            gpios = <&pio 241 GPIO_ACTIVE_HIGH>;
> +        green {
> +            label = "bpi-r2:pio:green";
> +            gpios = <&pio 241 GPIO_ACTIVE_LOW>;
>              default-state = "off";
>          };
>  
> -        green {
> -            label = "bpi-r2:pio:green";
> -            gpios = <&pio 240 GPIO_ACTIVE_HIGH>;
> +        blue {
> +            label = "bpi-r2:pio:blue";
> +            gpios = <&pio 240 GPIO_ACTIVE_LOW>;
>              default-state = "off";
>          };
>  
>          red {
>              label = "bpi-r2:pio:red";
> -            gpios = <&pio 239 GPIO_ACTIVE_HIGH>;
> +            gpios = <&pio 239 GPIO_ACTIVE_LOW>;
>              default-state = "off";
>          };
>      };
>  

Hi, Frank

Node name should be listed in alphabetic order that means you should
keep the order and only have the fixes for its content.

Apart from that
	Reviewed-by: Sean Wang <sean.wang@mediatek.com>
	
>  
>  
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
