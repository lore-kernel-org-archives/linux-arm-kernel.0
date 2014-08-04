From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Aug 2014 12:34:29 +0200
Subject: [PATCH 2/2] ARM: crypto: enable NEON SHA-384/SHA-512 for big endian
In-Reply-To: <1407148469-26190-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1407148469-26190-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1407148469-26190-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SHA-512 NEON works just fine under big endian, so remove the Kconfig
condition preventing it from being selected if CONFIG_CPU_BIG_ENDIAN is set.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index deef2a4b6559..d560c66125bd 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -602,7 +602,7 @@ config CRYPTO_SHA512_SPARC64
 
 config CRYPTO_SHA512_ARM_NEON
 	tristate "SHA384 and SHA512 digest algorithm (ARM NEON)"
-	depends on ARM && KERNEL_MODE_NEON && !CPU_BIG_ENDIAN
+	depends on ARM && KERNEL_MODE_NEON
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
-- 
1.8.3.2
