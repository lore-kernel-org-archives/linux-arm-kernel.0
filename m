From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Sep 2012 21:26:15 +1000
Subject: linux-next: build failure after merge of the final tree (arm-soc
 tree related)
Message-ID: <20120917212615.91bc134d237dcd5968f9f549@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the final tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/mfd/twl-core.c:49:22: fatal error: plat/cpu.h: No such file or directory

Caused by commit 7d7e1eba7e92 ("ARM: OMAP2+: Prepare for irqs.h removal").

I have added the following patch to restrict this driver to ARM until it
is fixed:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 17 Sep 2012 21:18:21 +1000
Subject: [PATCH] ARM: retrict TWL4030_CORE to ARM while it is broken

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/mfd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index df850c4..af5e5b7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -257,6 +257,7 @@ config MENELAUS
 config TWL4030_CORE
 	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
 	depends on I2C=y && GENERIC_HARDIRQS
+	depends on ARM
 	select IRQ_DOMAIN
 	help
 	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
-- 
1.7.10.280.gaa39

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/4435ad6a/attachment.sig>
