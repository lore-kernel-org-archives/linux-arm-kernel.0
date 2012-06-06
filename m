From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jun 2012 17:39:07 +0300
Subject: 
In-Reply-To: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
References: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1338993547.6875.65.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-06 at 12:33 +0200, Sascha Hauer wrote:
> The following adds i.MX53 nand support and generally devicetree
> based probing for i.MX5 boards. The first three patches should go
> via mtd, the last patch optionally aswell if all agree.
> 
> Sascha
> 
> The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:
> 
>   Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/imx/linux-2.6.git imx/nand-mx53
> 
> for you to fetch changes up to d55d1479a3bfaedbb9f0c6c956f4dff6bb6d6d61:
> 
>   ARM i.MX5: Add nand oftree support (2012-06-06 12:20:24 +0200)

Do you want this to go via the MTD tree? Would you be able to collect
acks for the arch/arm bits? Meanwhile, please, take a look at these
sparse warnings added by this patch-set and detected by aiaiai:

--------------------------------------------------------------------------------

Successfully built configuration "arm-mxc-imx_defconfig,arm,arm-unknown-linux-gnueabi-", results:

--- before_patching.log
+++ after_patching.log
@@ @@
+drivers/mtd/nand/mxc_nand.c:1289:26: warning: incorrect type in initializer (different modifiers) [sparse]
+drivers/mtd/nand/mxc_nand.c:1289:26:    expected void *data [sparse]
+drivers/mtd/nand/mxc_nand.c:1289:26:    got struct mxc_nand_devtype_data static const [toplevel] *<noident> [sparse]
+drivers/mtd/nand/mxc_nand.c:1289:3: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120606/532bd4d9/attachment-0001.sig>
