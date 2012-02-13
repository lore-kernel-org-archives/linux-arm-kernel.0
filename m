From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 13 Feb 2012 14:08:11 +0200
Subject: [PATCH] MTD: atmel_nand: Update driver to support Programmable
 HW ECC controller
In-Reply-To: <1329117469-23637-1-git-send-email-hong.xu@atmel.com>
References: <1329117469-23637-1-git-send-email-hong.xu@atmel.com>
Message-ID: <1329134891.22240.116.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-02-13 at 15:17 +0800, Hong Xu wrote:
> The Programmable Hardware ECC (PMECC) controller is a programmable binary
> BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This controller
> can be used to support both SLC and MLC NAND Flash devices. It supports to
> generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector of data.
> 
> To use this driver, the user needs to pass in the correction capability and
> the sector size.
> 
> This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with JFFS2,
> YAFFS2, UBIFS and mtd-utils.
> 
> Signed-off-by: Hong Xu <hong.xu@atmel.com>

Please, do not forget to fix the following warnings as well:

Sparse:
+drivers/mtd/nand/atmel_nand.c:1446:52: warning: Using plain integer as NULL pointer [sparse]

gcc:
+drivers/mtd/nand/atmel_nand.c: In function 'atmel_nand_probe':
+drivers/mtd/nand/atmel_nand.c:1451:1: warning: label 'err' defined but not used [-Wunused-label]

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120213/407f1701/attachment.sig>
