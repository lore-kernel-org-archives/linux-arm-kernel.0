From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 14 Apr 2014 17:22:12 +0200
Subject: [PATCH] tty/serial: atmel_serial: Fix device tree documentation
In-Reply-To: <1397487482-3816-1-git-send-email-richard.genoud@gmail.com>
References: <1397487482-3816-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <20140414152212.GC2255@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Mon, Apr 14, 2014 at 04:58:02PM +0200, Richard Genoud wrote:
> RTS pin is an active low pin.
> For now, this doesn't change anything as the ACTIVE_LOW flag is not
> handled in atmel_serial, but it will be in 3.16.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/atmel-usart.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> index 17c1042b2df8..2f7aad71b3c9 100644
> --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> @@ -35,7 +35,7 @@ Example:
>  		clock-names = "usart";
>  		atmel,use-dma-rx;
>  		atmel,use-dma-tx;
> -		rts-gpios = <&pioD 15 0>;
> +		rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;

I was told we should not use macros here. If it is still the truth:

rts-gpios = <&pioD 15 1>;


Ludovic

>  	};
>  
>  - use DMA:
> -- 
> 1.8.5.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
