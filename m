From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 24 May 2013 21:55:25 +0200
Subject: [PATCH v2 0/4] mtd: atmel_nand: enable Nand Flash Controller
 (NFC) support
In-Reply-To: <1368784308-7600-1-git-send-email-josh.wu@atmel.com>
References: <1368784308-7600-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20130524195525.GL24476@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:51 Fri 17 May     , Josh Wu wrote:
> This patch series enable NFC support for SAMA5 soc. It can send command,
> address cycles automaticly. Also when enable NFC sram, NFC will transfer
> data to sram. Which can save lots of cpu time.

can you give some stats please

and performance comparaisan NFS vs DMA

Best Regards,
J.
> 
> v1 --> v2:
>  1) rebase it with latest l2-mtd git tree: 
>     - remove useless nand commands (NAND_CMD_DEPLETE1, NAND_CMD_STATUS_ERRORx).
>     - adopt to the new nand write function's parameters. Add error message when
>       handle subpage write via nfc sram.
>  2) rewrite pmecc_enable function. Now I use exist NAND_ECC_READ/WRITE const
>     instead of using a new enum definition.
> 
> Josh Wu (4):
>   mtd: atmel_nand: replace pmecc enable code with one function.
>   mtd: atmel_nand: add Nand Flash Controller (NFC) support
>   mtd: atmel_nand: enable Nand Flash Controller (NFC) read data via
>     sram
>   mtd: atmel_nand: enable Nand Flash Controller (NFC) write via sram
> 
>  .../devicetree/bindings/mtd/atmel-nand.txt         |    4 +
>  drivers/mtd/nand/atmel_nand.c                      |  657 ++++++++++++++++++--
>  drivers/mtd/nand/atmel_nand_nfc.h                  |  106 ++++
>  3 files changed, 718 insertions(+), 49 deletions(-)
>  create mode 100644 drivers/mtd/nand/atmel_nand_nfc.h
> 
> -- 
> 1.7.9.5
> 
