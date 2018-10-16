From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 16 Oct 2018 14:04:11 +0200
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
In-Reply-To: <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
 <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Message-ID: <20181016140411.3f06e449@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Oct 2018 09:51:47 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Tudor,
> 
> This patch is breaking the 1-4-4 Read protocol for the spansion flash "s25fl512s".
> 
> Without this patch read request command for Quad mode, 4-byte enable, is coming as 0xEC i.e. SPINOR_OP_READ_1_4_4_4B.
> But after applying this patch, read request command for Quad mode is coming as 0x6C i.e. SPINOR_OP_READ_1_1_4_4B.
> 
> This flash also supports non-uniform erase.
> Can you please check and provide some suggestion?

Are you sure the regression comes from this patch? I suspect your bug
comes from 41fe242979e4 ("mtd: spi-nor: fsl-quadspi: fix read error for
flash size larger than 16MB").
