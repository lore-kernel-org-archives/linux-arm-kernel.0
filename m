From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 29 Jun 2012 10:49:23 -0300
Subject: [PATCH 8/8] mmc: spi: Add DMA support into SPI driver
In-Reply-To: <1340958180-2291-8-git-send-email-marex@denx.de>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
 <1340958180-2291-8-git-send-email-marex@denx.de>
Message-ID: <CAOMZO5AN852f3Awv0UG+ApsgMC-x5ByQrLkUC5SkOnty5T0EMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 6/29/12, Marek Vasut <marex@denx.de> wrote:

>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!iores)
> +	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> +	irq_err = platform_get_irq(pdev, 0);
> +	irq_dma = platform_get_irq(pdev, 1);
> +	if (!iores || irq_err < 0 || irq_dma < 0)

Shouldn't you check for dmares < 0 here too?
