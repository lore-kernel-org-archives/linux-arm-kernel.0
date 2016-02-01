From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  1 Feb 2016 17:39:21 +0000
Subject: [PATCH 02/11] crypto: sunxi-ss: prevent compilation on 64-bit
In-Reply-To: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1454348370-3816-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver for the sunxi-ss crypto engine is not entirely 64-bit safe,
compilation on arm64 spits some warnings.
The proper fix was deemed to involved [1], so since 64-bit SoCs won't
have this IP block we just disable this driver for 64-bit.

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/399988.html
     (and the reply)

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 07d4942..737200f 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -487,7 +487,7 @@ config CRYPTO_DEV_IMGTEC_HASH
 
 config CRYPTO_DEV_SUN4I_SS
 	tristate "Support for Allwinner Security System cryptographic accelerator"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI && !64BIT
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_AES
-- 
2.6.4
