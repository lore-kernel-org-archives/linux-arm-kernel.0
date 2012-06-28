From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 28 Jun 2012 18:40:21 +0300
Subject: [PATCH v12 0/2] MTD: at91: Add PMECC support for at91 nand
 flash driver
In-Reply-To: <1340871698-477-1-git-send-email-josh.wu@atmel.com>
References: <1340871698-477-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1340898021.3070.123.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-28 at 16:21 +0800, Josh Wu wrote:
> Those patches is based on the l2-mtd.git three.
> 
> Since there are two patches of v11 already pushed, so this version v12 only includes the left two patches.
> which includes the modification according to Richard Genoud's review suggestion.
> 
> Changes since v11,
> 	add documentation for atmel nand reg parameter and one example for PMECC support.
> 	fix the bug: no error reported when fail to get resoures of PMECC ERRLOC or ROM.
> 	fix the bug: no correction when ecc data has bit flipped.
> 	add clearer debug information for data correction.
> 
> Josh Wu (2):
>   MTD: at91: add dt parameters for Atmel PMECC
>   MTD: at91: atmel_nand: Update driver to support Programmable Multibit
>     ECC controller
> 
>  .../devicetree/bindings/mtd/atmel-nand.txt         |   40 +-
>  drivers/mtd/nand/atmel_nand.c                      |  801 +++++++++++++++++++-
>  drivers/mtd/nand/atmel_nand_ecc.h                  |  114 ++-
>  3 files changed, 951 insertions(+), 4 deletions(-)

Aiaiai is not 100% happy, could you take a look?

dedekind at blue:~/git/maintaining$ ../aiaiai/aiaiai-concat-mboxes ~/tmp/wu* | ./verify ../l2-mtd/ atmel_nand
Tested the patch(es) on top of the following commits:
9328bb5 Quick fixes - applied by aiaiai
ea3b6ef mtd: fix bogus inequation
0960e57 mtd: move mtd_read_oob() definition out of mtd.h
0560176 mtd: nand_bbt: refactor check_pattern_no_oob()

--------------------------------------------------------------------------------

Successfully built configuration "arm-at91cap9_defconfig,arm,arm-unknown-linux-gnueabi-", results:

--- before_patching.log
+++ after_patching.log
@@ @@
+drivers/mtd/nand/atmel_nand.c: In function 'pmecc_correct_data':
+drivers/mtd/nand/atmel_nand.c:680:38: warning: variable 'ecc_size' set but not used [-Wunused-but-set-variable]
+drivers/mtd/nand/atmel_nand.c:480:32: error: bad constant expression [sparse]
+drivers/mtd/nand/atmel_nand.c:488:35: error: bad constant expression [sparse]
+drivers/mtd/nand/atmel_nand.c:633:32: error: bad constant expression [sparse]
+drivers/mtd/nand/atmel_nand.c:635:35: error: bad constant expression [sparse]

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120628/7dc4e586/attachment.sig>
