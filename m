From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Dec 2013 16:29:38 -0200
Subject: [PATCH 1/2] spi: spi-imx: enable dma support for escpi controller
In-Reply-To: <1387561378-2683-1-git-send-email-Frank.Li@freescale.com>
References: <1387561378-2683-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <CAOMZO5Au233myeoS0BVweJGTuAx91uBWU9QpiOHkiBSfC7KLsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 3:42 PM, Frank Li <Frank.Li@freescale.com> wrote:
> After enable DMA
>
> spi-nor read speed is
> dd if=/dev/mtd0 of=/dev/null bs=1M count=1
> 1+0 records in
> 1+0 records out
> 1048576 bytes (1.0 MB) copied, 0.720402 s, 1.5 MB/s

Good job, Frank!
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

You need to check if res is NULL here.

> +       spi_imx->mapbase = res->start;
>         spi_imx->base = devm_ioremap_resource(&pdev->dev, res);

Regards,

Fabio Estevam
