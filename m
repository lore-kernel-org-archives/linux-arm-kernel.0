From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2018 09:13:34 +0200
Subject: [PATCH 12/15] dmaengine: pxa: make the filter function internal
In-Reply-To: <201804030025.FmWPyArN%fengguang.wu@intel.com>
References: <20180402142656.26815-13-robert.jarzmik@free.fr>
 <201804030025.FmWPyArN%fengguang.wu@intel.com>
Message-ID: <CAK8P3a0T3HV9ee4Kk7+Y16S-51SLzbn5fRBsr4bSV0ZQnthPVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2018 at 6:35 PM, kbuild test robot <lkp@intel.com> wrote:

>
>    drivers/mtd/nand/marvell_nand.c:2621:17: sparse: undefined identifier 'pxad_filter_fn'
>>> drivers/mtd/nand/marvell_nand.c:2621:17: sparse: call with no type!
>    In file included from drivers/mtd/nand/marvell_nand.c:21:0:
>    drivers/mtd/nand/marvell_nand.c: In function 'marvell_nfc_init_dma':
>    drivers/mtd/nand/marvell_nand.c:2621:42: error: 'pxad_filter_fn' undeclared (first use in this function); did you mean 'dma_filter_fn'?
>       dma_request_slave_channel_compat(mask, pxad_filter_fn,
>                                              ^
>    include/linux/dmaengine.h:1408:46: note: in definition of macro 'dma_request_slave_channel_compat'
>      __dma_request_slave_channel_compat(&(mask), x, y, dev, name)
>                                                  ^
>    drivers/mtd/nand/marvell_nand.c:2621:42: note: each undeclared identifier is reported only once for each function it appears in
>       dma_request_slave_channel_compat(mask, pxad_filter_fn,
>                                              ^
>    include/linux/dmaengine.h:1408:46: note: in definition of macro 'dma_request_slave_channel_compat'
>      __dma_request_slave_channel_compat(&(mask), x, y, dev, name)

The driver is a replacement for the pxa3xx nand driver, so it now has
to get changed as well.

       Arnd
