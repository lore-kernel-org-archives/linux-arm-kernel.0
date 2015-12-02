From: robh@kernel.org (Rob Herring)
Date: Wed, 2 Dec 2015 08:28:18 -0600
Subject: [PATCH 2/4] i2c: at91: update bindings documention
In-Reply-To: <1449052747-20991-2-git-send-email-ludovic.desroches@atmel.com>
References: <1449052747-20991-1-git-send-email-ludovic.desroches@atmel.com>
 <1449052747-20991-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151202142818.GA15254@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 11:39:05AM +0100, Ludovic Desroches wrote:
> The i2c-sda-hold-time-ns property is supported from atmel,sama5d4-i2c.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> index 6e81dc1..67c6f2e 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> @@ -3,7 +3,7 @@ I2C for Atmel platforms
>  Required properties :
>  - compatible : Must be "atmel,at91rm9200-i2c", "atmel,at91sam9261-i2c",
>       "atmel,at91sam9260-i2c", "atmel,at91sam9g20-i2c", "atmel,at91sam9g10-i2c",
> -     "atmel,at91sam9x5-i2c" or "atmel,sama5d2-i2c"
> +     "atmel,at91sam9x5-i2c", "atmel,sama5d4-i2c" or "atmel,sama5d2-i2c"
>  - reg: physical base address of the controller and length of memory mapped
>       region.
>  - interrupts: interrupt number to the cpu.
> @@ -17,6 +17,7 @@ Optional properties:
>  - dma-names: should contain "tx" and "rx".
>  - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
>    capable I2C controllers.
> +- i2c-sda-hold-time-ns: TWD hold time, only available from "atmel,sama5d4-i2c".
>  - Child nodes conforming to i2c bus binding
>  
>  Examples :
> @@ -52,6 +53,7 @@ i2c0: i2c at f8034600 {
>  	#size-cells = <0>;
>  	clocks = <&flx0>;
>  	atmel,fifo-size = <16>;
> +	i2c-sda-hold-time-ns = <336>;
>  
>  	wm8731: wm8731 at 1a {
>  		compatible = "wm8731";
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
