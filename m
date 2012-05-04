From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 04 May 2012 13:37:39 +0300
Subject: [PATCH 1/2] mtd: gpmi: add device tree support to gpmi-nand
In-Reply-To: <4FA3AEDF.8010009@freescale.com>
References: <1336101182-5200-1-git-send-email-b32955@freescale.com>
 <1336124510.4275.7.camel@sauron.fi.intel.com>
 <4FA3AEDF.8010009@freescale.com>
Message-ID: <1336127859.4275.14.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-04 at 18:26 +0800, Huang Shijie wrote:
> ? 2012?05?04? 17:41, Artem Bityutskiy ??:
> > On Fri, 2012-05-04 at 11:13 +0800, Huang Shijie wrote:
> >> This patch just adds the DT support to gpmi-nand.
> >>
> >> Signed-off-by: Huang Shijie<b32955@freescale.com>
> >> ---
> >> Please select the CONFIG_USE_OF before you do the compiler-test.
> >> thanks.
> > It should compile without CONFIG_USE_OF also just fine. Currently it
> > does not.
> >
> why not select CONFIG_USE_OF as the gpmi-nand is converted to a DT driver.

Yes, it can be done as well. My point is that you should not break
compilation. These 2 patches do not compile with for me - aiaiai
reports:

--------------------------------------------------------------------------------
Failed to build the following commit for configuration "l2_mxs_defconfig" (architecture arm)":

d791f1c mtd: gpmi: add gpmi support for mx6q

drivers/mtd/nand/gpmi-nand/gpmi-lib.c:437:36: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
drivers/mtd/nand/gpmi-nand/gpmi-lib.c:579:35: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
In file included from include/linux/kernel.h:19:0,
                 from include/linux/clk.h:15,
                 from drivers/mtd/nand/gpmi-nand/gpmi-nand.c:21:
include/linux/bitops.h: In function 'hweight_long':
include/linux/bitops.h:66:26: warning: signed and unsigned type in conditional expression [-Wsign-compare]
In file included from include/linux/dma-mapping.h:73:0,
                 from drivers/mtd/nand/gpmi-nand/gpmi-nand.h:22,
                 from drivers/mtd/nand/gpmi-nand/gpmi-nand.c:28:
arch/arm/include/asm/dma-mapping.h: In function 'dma_mapping_error':
arch/arm/include/asm/dma-mapping.h:126:18: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function 'release_bch_irq':
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:382:11: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function 'acquire_dma_channels':
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:430:2: error: implicit declaration of function 'of_property_read_u32' [-Werror=implicit-function-declaration]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function 'mx23_check_transcription_stamp':
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1186:9: warning: variable 'byte' set but not used [-Wunused-but-set-variable]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function 'mx23_write_transcription_stamp':
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1247:15: warning: variable 'byte' set but not used [-Wunused-but-set-variable]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c: At top level:
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1448:6: warning: no previous prototype for 'gpmi_nfc_exit' [-Wmissing-prototypes]
cc1: some warnings being treated as errors
make[5]: *** [drivers/mtd/nand/gpmi-nand/gpmi-nand.o] Error 1

--------------------------------------------------------------------------------


-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120504/3fb0c6f3/attachment-0001.sig>
