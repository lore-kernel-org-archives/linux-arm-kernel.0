From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 15 Jan 2013 16:55:50 +0200
Subject: [PATCH v2] mtd: vt8500: Add support for Wondermedia Serial
 Flash Controller
In-Reply-To: <1356901207-13536-1-git-send-email-linux@prisktech.co.nz>
References: <1356901207-13536-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1358261750.2731.148.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-12-31 at 10:00 +1300, Tony Prisk wrote:
> This patch adds support for the Wondermedia serial flash controller
> found on WM8505, WM8650 and WM8850 SoCs.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> v2: Whitespace tidyup

Hi, would you please take a look at these warings, identified by aiaiai:

Successfully built configuration "x86_64_defconfig,x86_64,", results:

--- before_patching.log
+++ after_patching.log
@@ @@
+drivers/mtd/devices/wmt_sflash.c: In function ?sf_read?:
+drivers/mtd/devices/wmt_sflash.c:425:9: warning: format ?%d? expects argument of type ?int?, but argument 4 has type ?size_t? [-Wformat]
+drivers/mtd/devices/wmt_sflash.c: In function ?sf_sector_write?:
+drivers/mtd/devices/wmt_sflash.c:442:16: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
+drivers/mtd/devices/wmt_sflash.c:442:24: warning: cast removes address space of expression [sparse]
+drivers/mtd/devices/wmt_sflash.c:458:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
+drivers/mtd/devices/wmt_sflash.c:458:31: warning: incorrect type in argument 1 (different address spaces) [sparse]
+drivers/mtd/devices/wmt_sflash.c:458:31:    expected void volatile [noderef] <asn:2>*dst [sparse]
+drivers/mtd/devices/wmt_sflash.c:458:31:    got unsigned char [usertype] *<noident> [sparse]
+drivers/mtd/devices/wmt_sflash.c:465:17: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
+drivers/mtd/devices/wmt_sflash.c:465:39: warning: incorrect type in argument 1 (different address spaces) [sparse]
+drivers/mtd/devices/wmt_sflash.c:465:39:    expected void volatile [noderef] <asn:2>*dst [sparse]
+drivers/mtd/devices/wmt_sflash.c:465:39:    got unsigned char [usertype] *<noident> [sparse]

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130115/b6b91162/attachment.sig>
