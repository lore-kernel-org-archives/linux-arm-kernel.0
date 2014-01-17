From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 17 Jan 2014 10:23:10 +0100
Subject: [PATCH v2 resend 4/5] ARM: introduce HWCAP2 feature bits for ARMv8
 Crypto Extensions
In-Reply-To: <1389950591-4212-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1389950591-4212-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1389950591-4212-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allocates feature bits 0-4 in HWCAP2 for the crypto and CRC
extensions introduced in ARMv8.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/uapi/asm/hwcap.h | 5 +++++
 arch/arm/kernel/setup.c           | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
index 87768b5cffd1..20d12f230a2f 100644
--- a/arch/arm/include/uapi/asm/hwcap.h
+++ b/arch/arm/include/uapi/asm/hwcap.h
@@ -31,5 +31,10 @@
 /*
  * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
  */
+#define HWCAP2_AES	(1 << 0)
+#define HWCAP2_PMULL	(1 << 1)
+#define HWCAP2_SHA1	(1 << 2)
+#define HWCAP2_SHA2	(1 << 3)
+#define HWCAP2_CRC32	(1 << 4)
 
 #endif /* _UAPI__ASMARM_HWCAP_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ce3049c89c18..ac3a7f218b7f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -996,6 +996,11 @@ static const char *hwcap_str[] = {
 };
 
 static const char *hwcap2_str[] = {
+	"aes",
+	"pmull",
+	"sha1",
+	"sha2",
+	"crc32",
 	NULL
 };
 
-- 
1.8.3.2
