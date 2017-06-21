From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 21 Jun 2017 21:16:57 +0200
Subject: [PATCH 2/4] ARM: exynos_defconfig: Enable NLS_UTF8 and some crypto
 algorithms
In-Reply-To: <20170621191659.10929-1-krzk@kernel.org>
References: <20170621191659.10929-1-krzk@kernel.org>
Message-ID: <20170621191659.10929-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable useful, but not essential components:
 - NLS_UTF8, it might be used for accessing Microsoft-FS based storages,
 - popular crypto algorithms and transformations as modules.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/exynos_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index e6a976f5305c..dfe43acec129 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -308,6 +308,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
@@ -319,7 +320,18 @@ CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_USER=y
+CONFIG_CRYPTO_RSA=m
+CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_USER=m
+CONFIG_CRYPTO_TEST=m
+CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_XTS=m
+CONFIG_CRYPTO_MD5=m
+CONFIG_CRYPTO_SHA512=m
+CONFIG_CRYPTO_SHA3=m
+CONFIG_CRYPTO_SALSA20=m
+CONFIG_CRYPTO_LZO=m
+CONFIG_CRYPTO_LZ4=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
@@ -331,6 +343,7 @@ CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
+CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRC_CCITT=y
 CONFIG_FONTS=y
 CONFIG_FONT_7x14=y
-- 
2.9.3
