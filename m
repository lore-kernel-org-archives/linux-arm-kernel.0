From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Feb 2018 09:26:36 +0000
Subject: [PATCH 1/2] arm64: defconfig: add newly added accelerated crypto
 modules
Message-ID: <20180214092637.14047-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New crypto drivers have been introduced in v4.16 that implement the
SHA-512, SHA3 and SM3 secure hash algorithms using ARMv8.2 optional
instructions. Add these drivers to arm64's defconfig as modules.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373785c4..e718c64c47e4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -629,3 +629,6 @@ CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
 CONFIG_CRYPTO_AES_ARM64_NEON_BLK=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_AES_ARM64_BS=m
+CONFIG_CRYPTO_SHA512_ARM64_CE=m
+CONFIG_CRYPTO_SHA3_ARM64=m
+CONFIG_CRYPTO_SM3_ARM64_CE=m
-- 
2.11.0
