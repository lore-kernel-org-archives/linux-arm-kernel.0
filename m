From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 23 Oct 2009 11:48:26 +0200
Subject: [at91sam9g45] DMA driver for AC97 and MCI
In-Reply-To: <4ABCBD32.7080408@visionsystems.de>
References: <4ABCBD32.7080408@visionsystems.de>
Message-ID: <4AE17BEA.2080209@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yegor Yefremov :
> I try to get sound and SD card working on at91sam9g45-ekes development board using linux-next tree. As far as I understand AT_HDMAC is the appropriate DMA driver for ARCH_AT91SAM9G45. I resolved dependencies with this patch, so I could activate it for my platform.
> 
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -48,7 +48,7 @@ config DW_DMAC
> 
>  config AT_HDMAC
>         tristate "Atmel AHB DMA support"
> -       depends on ARCH_AT91SAM9RL
> +       depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
>         select DMA_ENGINE
>         help
>           Support the Atmel AHB DMA controller.  This can be integrated in
> 

Yegor,

As the preceding patch is now in mainline, maybe you can submit this one
to Russell patch tracking system (or tell me to do so).

Anyway, you can add my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Best regards,
-- 
Nicolas Ferre
