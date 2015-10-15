From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 15 Oct 2015 13:52:27 +0200
Subject: [PATCH v3 1/4] mtd: nand: allow compile test of MTD_NAND_PXA3xx
In-Reply-To: <5425922.4Qu1HbLqzM@wuerfel>
References: <201510151736.7t9qDlAe%fengguang.wu@intel.com>
 <5425922.4Qu1HbLqzM@wuerfel>
Message-ID: <20151015115227.GA21506@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Oct 15, 2015 at 01:44:19PM +0200, Arnd Bergmann wrote:
> On Thursday 15 October 2015 17:12:18 kbuild test robot wrote:
> >    drivers/mtd/nand/pxa3xx_nand.c: In function 'drain_fifo':
> > >> drivers/mtd/nand/pxa3xx_nand.c:507:4: error: implicit declaration of function 'readsl' [-Werror=implicit-function-declaration]
> >        readsl(info->mmio_base + NDDB, data, 8);
> >        ^
> 
> It should be easy to fix this by changing the code to use ioread32_rep() instead
> of readsl(). They behave the same way on pointers returned from ioremap() etc,
> and the other one is available on all architectures.

Sure, I can add a patch fixing this prior to the one allowing to compile
test the pxa3xx nand driver.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
