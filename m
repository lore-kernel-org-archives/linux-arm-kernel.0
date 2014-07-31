From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 31 Jul 2014 10:56:42 +0200
Subject: [PATCH] arm64: defconfig: enable crypto drivers as modules
Message-ID: <1406797002-21015-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the arm64 defconfig to build the ARMv8 Crypto Extensions
and NEON based crypto drivers as modules rather than as built-ins. The
reason is that the ARMv8 Crypto Extensions based modules will be probed
for automatically through udev upon detecting the availability of the
respective crypto instructions (AES, PMULL, SHA1, SHA256), and similarly,
the NEON alternatives will be probed for upon request (i.e., at first use
of the algorithm) if no hardware acceleration is available.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/configs/defconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c1071268c912..3310b4166dd0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -127,10 +127,10 @@ CONFIG_LOCKUP_DETECTOR=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
 CONFIG_ARM64_CRYPTO=y
-CONFIG_CRYPTO_SHA1_ARM64_CE=y
-CONFIG_CRYPTO_SHA2_ARM64_CE=y
-CONFIG_CRYPTO_GHASH_ARM64_CE=y
-CONFIG_CRYPTO_AES_ARM64_CE=y
-CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
-CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
-CONFIG_CRYPTO_AES_ARM64_NEON_BLK=y
+CONFIG_CRYPTO_SHA1_ARM64_CE=m
+CONFIG_CRYPTO_SHA2_ARM64_CE=m
+CONFIG_CRYPTO_GHASH_ARM64_CE=m
+CONFIG_CRYPTO_AES_ARM64_CE=m
+CONFIG_CRYPTO_AES_ARM64_CE_CCM=m
+CONFIG_CRYPTO_AES_ARM64_CE_BLK=m
+CONFIG_CRYPTO_AES_ARM64_NEON_BLK=m
-- 
1.8.3.2
