From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 20 May 2014 09:40:53 -0300
Subject: [linux-sunxi] [PATCH v7] DMA: sun6i: Add driver for the Allwinner
 A31 DMA controller
In-Reply-To: <1398349364-10726-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1398349364-10726-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398349364-10726-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <537B4D55.5040804@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 24/04/14 11:22, Maxime Ripard escribi?:
> The Allwinner A31 has a 16 channels DMA controller that it shares with the
> newer A23. Although sharing some similarities with the DMA controller of the
> older Allwinner SoCs, it's significantly different, I don't expect it to be
> possible to share the driver for these two.
>
> The A31 Controller is able to memory-to-memory or memory-to-device transfers on
> the 16 channels in parallel.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
(snip)
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 5c5863842de9..360a10c71388 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -361,6 +361,14 @@ config FSL_EDMA
>   	  multiplexing capability for DMA request sources(slot).
>   	  This module can be found on Freescale Vybrid and LS-1 SoCs.
>
> +config DMA_SUN6I
> +	tristate "Allwinner A31 SoCs DMA support"
> +	depends on ARCH_SUNXI
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS

I think you also need to select DMA_OF here as you are using 
of_dma_controller_register

> +	help
> +	  Support for the DMA engine for Allwinner A31 SoCs.
> +
>   config DMA_ENGINE
>   	bool

Cheers,

Emilio
