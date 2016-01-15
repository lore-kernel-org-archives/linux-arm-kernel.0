From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 15 Jan 2016 10:01:49 -0800
Subject: [PATCH] mtd: mtk-nor: Drop bogus __init from mtk_nor_init()
In-Reply-To: <1452865589-555-1-git-send-email-geert@linux-m68k.org>
References: <1452865589-555-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20160115180149.GT109450@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 02:46:29PM +0100, Geert Uytterhoeven wrote:
> WARNING: drivers/mtd/spi-nor/mtk-quadspi.o(.text+0x77e): Section mismatch in reference from the function mtk_nor_drv_probe() to the function .init.text:mtk_nor_init()
> The function mtk_nor_drv_probe() references
> the function __init mtk_nor_init().
> This is often because mtk_nor_drv_probe lacks a __init
> annotation or the annotation of mtk_nor_init is wrong.
> 
> Drop the bogus __init from mtk_nor_init() to kill this warning.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Presumably this went unnoticed because some versions of gcc inline
> mtk_nor_init()?

Pushed to l2-mtd.git. Thanks!
