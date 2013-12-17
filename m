From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Dec 2013 14:07:32 +0100
Subject: [PATCH v3 3/7] mtd: spi-nor: add the framework for SPI NOR
In-Reply-To: <1387184330-14448-4-git-send-email-b32955@freescale.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <1387184330-14448-4-git-send-email-b32955@freescale.com>
Message-ID: <201312171407.32714.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 16, 2013 at 09:58:46 AM, Huang Shijie wrote:
> This patch cloned most of the m25p80.c. In theory, it adds a new spi-nor
> layer.
> 
> Before this patch, the layer is like:
> 
>                    MTD
>          ------------------------
>                   m25p80
>          ------------------------
> 	       spi bus driver
>          ------------------------
> 	        SPI NOR chip
> 
> After this patch, the layer is like:
>                    MTD
>          ------------------------
>                   spi-nor
>          ------------------------
>                   m25p80
>          ------------------------
> 	       spi bus driver
>          ------------------------
> 	       SPI NOR chip
> 
> With the spi-nor controller driver(Freescale Quadspi), it looks like:
>                    MTD
>          ------------------------
>                   spi-nor
>          ------------------------
>                 fsl-quadspi
>          ------------------------
> 	       SPI NOR chip
> 
> New APIs:
>    spi_nor_scan: used to scan a spi-nor flash.

Document every single one function with a proper kernel-doc style annotations 
please.

Best regards,
Marek Vasut
