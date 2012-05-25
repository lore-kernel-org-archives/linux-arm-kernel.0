From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Fri, 25 May 2012 17:58:22 +0300
Subject: [PATCH 1/2] mtd mxc_nand: use 32bit copy functions
In-Reply-To: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
References: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1337957902.30969.46.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-25 at 16:22 +0200, Sascha Hauer wrote:
> The following commit changes the function used to copy from/to
> the hardware buffer to memcpy_[from|to]io. This does not work
> since the hardware cannot handle the byte accesses used by these
> functions. Instead of reverting this patch introduce 32bit
> correspondents of these functions.

Could you please take a look at the checkpatch.pl updates?

WARNING:LONG_LINE: line over 80 characters
#103: FILE: drivers/mtd/nand/mxc_nand.c:276:
+static void memcpy32_fromio(void *trg, const volatile void __iomem  *src, size_t size)

WARNING:VOLATILE: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
#103: FILE: drivers/mtd/nand/mxc_nand.c:276:
+static void memcpy32_fromio(void *trg, const volatile void __iomem  *src, size_t size)

WARNING:VOLATILE: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
#107: FILE: drivers/mtd/nand/mxc_nand.c:280:
+       const volatile u32 *s = src;

WARNING:VOLATILE: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
#113: FILE: drivers/mtd/nand/mxc_nand.c:286:
+static void memcpy32_toio(volatile void __iomem *trg, const void *src, int size)

WARNING:VOLATILE: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
#116: FILE: drivers/mtd/nand/mxc_nand.c:289:
+       volatile u32 *t = trg;

WARNING:LONG_LINE: line over 80 characters
#170: FILE: drivers/mtd/nand/mxc_nand.c:1093:
+               memcpy32_fromio(host->data_buf, host->main_area0, mtd->writesize);

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120525/e753d664/attachment.sig>
