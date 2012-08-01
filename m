From: marex@denx.de (Marek Vasut)
Date: Wed, 1 Aug 2012 08:29:19 +0200
Subject: [PATCH 08/10 V2] spi: Add DMA support into SPI driver
In-Reply-To: <1341555449-17507-8-git-send-email-marex@denx.de>
References: <1341555449-17507-1-git-send-email-marex@denx.de>
 <1341555449-17507-8-git-send-email-marex@denx.de>
Message-ID: <201208010829.19404.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek Vasut,

[...]

> -out_host_free:
> +out_free_dma:
> +	dma_release_channel(ssp->dmach);
>  	clk_disable_unprepare(ssp->clk);
> +out_host_free:
>  	spi_master_put(host);
>  	kfree(host);
> +

Please remove this newline.

>  	return ret;
>  }

Missing dma_release_channel() in .remove!

Best regards,
Marek Vasut
