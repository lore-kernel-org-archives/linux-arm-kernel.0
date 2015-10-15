From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 13:44:19 +0200
Subject: [PATCH v3 1/4] mtd: nand: allow compile test of MTD_NAND_PXA3xx
In-Reply-To: <201510151736.7t9qDlAe%fengguang.wu@intel.com>
References: <201510151736.7t9qDlAe%fengguang.wu@intel.com>
Message-ID: <5425922.4Qu1HbLqzM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 17:12:18 kbuild test robot wrote:
>    drivers/mtd/nand/pxa3xx_nand.c: In function 'drain_fifo':
> >> drivers/mtd/nand/pxa3xx_nand.c:507:4: error: implicit declaration of function 'readsl' [-Werror=implicit-function-declaration]
>        readsl(info->mmio_base + NDDB, data, 8);
>        ^

It should be easy to fix this by changing the code to use ioread32_rep() instead
of readsl(). They behave the same way on pointers returned from ioremap() etc,
and the other one is available on all architectures.

	Arnd
