From: marex@denx.de (Marek Vasut)
Date: Tue, 4 Mar 2014 23:17:29 +0100
Subject: [PATCH v5 0/8] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <1393238262-8622-1-git-send-email-b32955@freescale.com>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
Message-ID: <201403042317.29722.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 24, 2014 at 11:37:34 AM, Huang Shijie wrote:
> 1.) Why add a new framework for SPI NOR?
>   The SPI-NOR controller such as Freescale's Quadspi controller is working
>   in a different way from the SPI bus. It should knows the NOR commands to
>   find the right LUT sequence. Unfortunately, the current code can not meet
>   this requirement.
> 
> 2.) How does this patch set do?
>    This patch set adds a new spi-nor layer.
>    Before this patch, the layer is like:
> 
>                    MTD
>          ------------------------
>                   m25p80
>          ------------------------
> 	       spi bus driver
>          ------------------------
> 	        SPI NOR chip
> 
>    After this patch, the layer is like:
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
>   With the spi-nor controller driver(Freescale Quadspi), it looks like:
>                    MTD
>          ------------------------
>                   spi-nor
>          ------------------------
>                 fsl-quadspi
>          ------------------------
> 	       SPI NOR chip
> 
> 3.) more details
>     This patch set adds a new data structrue spi_nor{}, clones most the
> common code to spi-nor.c. Add spi_nor_xfer_cfg {} for the fundamental
> primitives: read_xfer/write_xfer.
> 
>     Make the m25p80.c/fsl_quaspi.c use the new APIs.
> 
> 4.) Change log:
> v4 --> v5:
> 	[1] rebase the patch set on the l2-mtd tree.
> 	[2] fixed bugs in the fsl-quadspi driver.
> 	[3] tested the fsl-quadspi with imx6sx board.

It's starting to take a really nice shape, I really like it :)
