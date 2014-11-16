From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 16 Nov 2014 22:02:33 +0100
Subject: [PATCHv2 4/8] arm: mvebu: use recently introduced uart label for
 stdout-path
In-Reply-To: <8b2c3e42793a9276e7b8ded0623675b95a5f68c2.1416158990.git.arno@natisbad.org>
References: <cover.1416158990.git.arno@natisbad.org>
 <8b2c3e42793a9276e7b8ded0623675b95a5f68c2.1416158990.git.arno@natisbad.org>
Message-ID: <20141116210233.GI15870@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 06:37:25PM +0100, Arnaud Ebalard wrote:
> 
> Now that labels for uartX are available in Marvell Armada .dtsi files,
> this patch replaces the "/soc/internal-regs/serial at 12000" found in
> armada-xp-lenovo-ix4-300d.dts file for stdout-path property by the more
> concise &uart0.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>

Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks for the patch

       Andrew

> ---
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> index 469cf7137595..cccf54784c4c 100644
> --- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> +++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> @@ -22,7 +22,7 @@
>  
>  	chosen {
>  		bootargs = "console=ttyS0,115200 earlyprintk";
> -		stdout-path = "/soc/internal-regs/serial at 12000";
> +		stdout-path = &uart0;
>  	};
>  
>  	memory {
> -- 
> 2.1.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
