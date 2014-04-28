From: marex@denx.de (Marek Vasut)
Date: Mon, 28 Apr 2014 22:23:58 +0200
Subject: [PATCH v2 03/10] mtd: spi-nor: add DDR quad read support
In-Reply-To: <1398657227-20721-4-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <1398657227-20721-4-git-send-email-b32955@freescale.com>
Message-ID: <201404282223.58671.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 28, 2014 at 05:53:40 AM, Huang Shijie wrote:
> This patch adds the DDR quad read support by the following:
> 
>   [1] add SPI_NOR_DDR_QUAD read mode.
> 
>   [2] add DDR Quad read opcodes:
>        SPINOR_OP_READ_1_4_4_D / SPINOR_OP_READ4_1_4_4_D
> 
>   [3] add set_ddr_quad_mode() to initialize for the DDR quad read.
>       Currently it only works for Spansion NOR.
> 
>   [3] about the dummy cycles.
>       We set the dummy with 8 for DDR quad read by default.
>       The m25p80.c can not support the DDR quad read, but the SPI NOR
> controller can set the dummy value in its child DT node, and the SPI NOR
> framework can parse it out.
> 
> Test this patch for Spansion s25fl128s NOR flash.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
