From: joelf@ti.com (Joel Fernandes)
Date: Sat, 17 Aug 2013 21:42:35 -0500
Subject: [PATCH v2 14/14] crypto: omap-aes: Kconfig: Add build support for
 AM437x
In-Reply-To: <1376793755-30478-1-git-send-email-joelf@ti.com>
References: <1376793755-30478-1-git-send-email-joelf@ti.com>
Message-ID: <1376793755-30478-15-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For AM437x SoC, ARCH_OMAP2 and ARCH_OMAP3 is not enabled in the defconfig. We
follow same thing as SHA driver, and add depends on ARCH_OMAP2PLUS so that the
config is selectable for AES driver on AM437x SoC builds.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/crypto/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index dffb855..e289afa 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -252,7 +252,7 @@ config CRYPTO_DEV_OMAP_SHAM
 
 config CRYPTO_DEV_OMAP_AES
 	tristate "Support for OMAP AES hw engine"
-	depends on ARCH_OMAP2 || ARCH_OMAP3
+	depends on ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP2PLUS
 	select CRYPTO_AES
 	select CRYPTO_BLKCIPHER2
 	help
-- 
1.7.9.5
