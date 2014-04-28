From: marex@denx.de (Marek Vasut)
Date: Mon, 28 Apr 2014 22:23:26 +0200
Subject: [PATCH v2 02/10] mtd: spi-nor: add a new field for spi_nor{}
In-Reply-To: <1398657227-20721-3-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <1398657227-20721-3-git-send-email-b32955@freescale.com>
Message-ID: <201404282223.26174.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 28, 2014 at 05:53:39 AM, Huang Shijie wrote:
> We need the SPI NOR child node to store some specific features, such as the
> dummy cycles for the DDR Quad read.
> 
> But now, we only have the @dev field in the spi_nor{}. The @dev may points
> to a spi_device{} for m25p80, while it may points to a platform_deivice{}
> for the SPI NOR controller, such as fsl_quadspi.c.
> 
> It is not convenient for us to get come information from the SPI NOR flash.
> 
> This patch adds a new field @np to spi_nor{}, it points to the child node
> for the SPI NOR flash.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Just handle the case where dev->of_node == NULL instead ?

Best regards,
Marek Vasut
