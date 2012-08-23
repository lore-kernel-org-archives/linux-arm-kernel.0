From: trini@ti.com (Tom Rini)
Date: Wed, 22 Aug 2012 23:01:23 -0700
Subject: [PATCH v3 0/3] DaVinci DMA engine conversion
In-Reply-To: <1345684176-21472-1-git-send-email-mporter@ti.com>
References: <1345684176-21472-1-git-send-email-mporter@ti.com>
Message-ID: <20120823060123.GA12312@bill-the-cat>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 09:09:33PM -0400, Matt Porter wrote:

[snip]
> Matt Porter (3):
>   dmaengine: add TI EDMA DMA engine driver
>   mmc: davinci_mmc: convert to DMA engine API
>   spi: spi-davinci: convert to DMA engine API
> 
>  drivers/dma/Kconfig            |   10 +
>  drivers/dma/Makefile           |    1 +
>  drivers/dma/edma.c             |  671 ++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/davinci_mmc.c |  271 +++++-----------
>  drivers/spi/spi-davinci.c      |  292 ++++++++---------
>  include/linux/edma.h           |   29 ++
>  6 files changed, 923 insertions(+), 351 deletions(-)
>  create mode 100644 drivers/dma/edma.c
>  create mode 100644 include/linux/edma.h

On the Logic PD AM1808 EVM:
mmc0 rootfs: http://pastebin.com/HKVdmA0G
jffs2 on the SPI flash rootfs: http://pastebin.com/cpAHgdug

Tested-by: Tom Rini <trini@ti.com>

-- 
Tom
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/41135f2d/attachment.sig>
