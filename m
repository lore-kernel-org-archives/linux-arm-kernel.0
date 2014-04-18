From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Apr 2014 17:31:29 +0200
Subject: [PATCH] ARM: at91: fix spi cs on sama5d3 Xplained board
In-Reply-To: <1396336363-13709-1-git-send-email-voice.shen@atmel.com>
References: <1396336363-13709-1-git-send-email-voice.shen@atmel.com>
Message-ID: <53514551.8030601@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2014 09:12, Bo Shen :
> The PD16 is the CS3 for SPI0 while not SPI1.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Okay, queued in at91-3.15-fixes. Thanks



> ---
> This patch is based on v3.14-rc8
> 
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> index ce13755..4537259 100644
> --- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> @@ -34,7 +34,7 @@
>  			};
>  
>  			spi0: spi at f0004000 {
> -				cs-gpios = <&pioD 13 0>;
> +				cs-gpios = <&pioD 13 0>, <0>, <0>, <&pioD 16 0>;
>  				status = "okay";
>  			};
>  
> @@ -79,7 +79,7 @@
>  			};
>  
>  			spi1: spi at f8008000 {
> -				cs-gpios = <&pioC 25 0>, <0>, <0>, <&pioD 16 0>;
> +				cs-gpios = <&pioC 25 0>;
>  				status = "okay";
>  			};
>  
> 


-- 
Nicolas Ferre
