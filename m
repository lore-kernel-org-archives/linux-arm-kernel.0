From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 May 2014 10:46:52 +0200
Subject: [PATCHv2] mmc: dw_mmc: change to use recommended reset procedure
In-Reply-To: <1399945121-7387-1-git-send-email-sonnyrao@chromium.org>
References: <1399945121-7387-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <4576681.G7gtKHPGQn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 May 2014 18:38:41 Sonny Rao wrote:
> +#ifndef CONFIG_MMC_DW_IDMAC
> +       if (host->use_dma)
> +               flags |= SDMMC_CTRL_DMA_RESET;
> +#endif

Can you change the above like this?

	if (IS_ENABLED(CONFIG_MMC_DW_IDMAC) && host->use_dma)
		flags |= SDMMC_CTRL_DMA_RESET;

That is generally considered the preferred style these days.

	Arnd
