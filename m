From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 13:34:26 -0800
Subject: [PATCH v2 16/18] arm64: crypto: disable LTO for aes-ce-cipher.c
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171115213428.22559-17-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_LTO_CLANG requires the use of clang's integrated assembler, which
doesn't understand the inline assembly in aes-ce-cipher.c. Disable LTO for
the file to work around the issue.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index b5edc5918c28..af08508521a3 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_CRYPTO_CRC32_ARM64_CE) += crc32-ce.o
 crc32-ce-y:= crc32-ce-core.o crc32-ce-glue.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM64_CE) += aes-ce-cipher.o
-CFLAGS_aes-ce-cipher.o += -march=armv8-a+crypto
+CFLAGS_aes-ce-cipher.o += -march=armv8-a+crypto $(DISABLE_LTO_CLANG)
 
 obj-$(CONFIG_CRYPTO_AES_ARM64_CE_CCM) += aes-ce-ccm.o
 aes-ce-ccm-y := aes-ce-ccm-glue.o aes-ce-ccm-core.o
-- 
2.15.0.448.gf294e3d99a-goog
