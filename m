From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 29 Jun 2012 15:37:14 +0300
Subject: [PATCH v10] MTD: LPC32xx MLC NAND driver
In-Reply-To: <1340834129-15545-1-git-send-email-stigge@antcom.de>
References: <1340834129-15545-1-git-send-email-stigge@antcom.de>
Message-ID: <1340973434.3070.168.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-27 at 23:55 +0200, Roland Stigge wrote:
> This patch adds a driver for the MLC NAND controller of the LPC32xx SoC.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> ---

Aiaiai complains like this about your patch, please, take a look:

--------------------------------------------------------------------------------

Successfully built configuration "arm-lpc32xx_defconfig,arm,arm-unknown-linux-gnueabi-", results:

--- before_patching.log
+++ after_patching.log
@@ @@
+drivers/mtd/nand/lpc32xx_mlc.c: In function 'lpc32xx_nand_probe':
+drivers/mtd/nand/lpc32xx_mlc.c:679:10: warning: variable 'sr' set but not used [-Wunused-but-set-variable]
+drivers/mtd/nand/lpc32xx_mlc.c:561:24: error: bad constant expression [sparse]

--------------------------------------------------------------------------------

checkpatch.pl has some complaints:

--------------------------------------------------------------------------------

checkpatch.pl results for patch "[PATCH] MTD: LPC32xx MLC NAND driver"

ERROR:INITIALISED_STATIC: do not initialise statics to 0 or NULL
#339: FILE: drivers/mtd/nand/lpc32xx_mlc.c:224:
+static int use_dma = 0;

total: 1 errors, 0 warnings, 1004 lines checked

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120629/09247dba/attachment.sig>
