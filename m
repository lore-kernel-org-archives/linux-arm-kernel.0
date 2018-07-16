From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 16 Jul 2018 11:16:56 +0200
Subject: [dts] [v2] fix green/blue pio-led on bananapi-r2
In-Reply-To: <trinity-28694d63-092a-48be-aade-ba680b5c4e70-1529921159405@3c-app-gmx-bs16>
References: <trinity-ae29ad25-a4fb-47f3-8d68-f6e58c875a0e-1529682447976@3c-app-gmx-bs42>
 <trinity-0d48bc23-f754-4da3-af01-c3a7abe1d34b-1529682783853@3c-app-gmx-bs42>
 <1529918263.29697.31.camel@mtkswgap22>
 <trinity-28694d63-092a-48be-aade-ba680b5c4e70-1529921159405@3c-app-gmx-bs16>
Message-ID: <13bab02e-0dc7-0ad9-3dde-fa4eef9e4411@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/06/18 12:05, Frank Wunderlich wrote:
> 
> From: Frank Wunderlich <frank-w@public-files.de>
> Date: Mon, 25 Jun 2018 11:57:13 +0200
> Subject: [PATCH] [dts] [v2] fix green/blue pio-led
>  pio-leds (near GPIO-Header) are swapped and LOW-active 
>  patch restore this expected behaviour
>  red cannot be switched afaik
> 
> v2: alphabetic order
> 

I fixed the commit message and pushed it to v4.18-next/dts32

> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 531d905d924ff..2b760f90f38c8 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -91,19 +91,19 @@
>  
>  		blue {
>  			label = "bpi-r2:pio:blue";
> -			gpios = <&pio 241 GPIO_ACTIVE_HIGH>;
> +			gpios = <&pio 240 GPIO_ACTIVE_LOW>;
>  			default-state = "off";
>  		};
>  
>  		green {
>  			label = "bpi-r2:pio:green";
> -			gpios = <&pio 240 GPIO_ACTIVE_HIGH>;
> +			gpios = <&pio 241 GPIO_ACTIVE_LOW>;
>  			default-state = "off";
>  		};
>  
>  		red {
>  			label = "bpi-r2:pio:red";
> -			gpios = <&pio 239 GPIO_ACTIVE_HIGH>;
> +			gpios = <&pio 239 GPIO_ACTIVE_LOW>;
>  			default-state = "off";
>  		};
>  	};
> 
> ?
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
