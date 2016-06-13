From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 13 Jun 2016 16:57:22 +0200
Subject: [PATCH] arm64: defconfig: disable plain NEON implementation of AES
Message-ID: <1465829842-3668-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The plain NEON implementation of AES is only suited for v8 cores that lack
the ARMv8 Crypto Extensions but have an implementation of the NEON tbl/tbx
instruction that is not pathetically slow. Unfortunately, this is currently
the empty set, so there is no point in including this implementation by
default. So disable it.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d0491e..ab76f74e859b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -343,5 +343,5 @@ CONFIG_CRYPTO_SHA2_ARM64_CE=y
 CONFIG_CRYPTO_GHASH_ARM64_CE=y
 CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
 CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
-CONFIG_CRYPTO_AES_ARM64_NEON_BLK=y
+# CONFIG_CRYPTO_AES_ARM64_NEON_BLK is not set
 CONFIG_CRYPTO_CRC32_ARM64=y
-- 
1.9.1
