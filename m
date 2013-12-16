From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Dec 2013 22:04:37 +0100
Subject: [PATCH 3/4] ARM: allocate hwcaps bits for v8 crypto extensions
In-Reply-To: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1387227878-30438-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM binaries running under an arm64 kernel are able to use
the special 32 bit versions of the v8 Crypto Extensions.

Even if the ARM port itself does not cover systems with such
capabilities, the allocation of 32-bit hwcaps bits should be
aligned between ARM and arm64 so a 32-bit userland does not need
to care about the difference.

This patch allocates bits 22-26 for the Crypto Extensions AES,
PMULL.64, SHA1, SHA2 and CRC32 respectively.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/uapi/asm/hwcap.h | 5 +++++
 arch/arm/kernel/setup.c           | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
index 7dcc10d..0726024 100644
--- a/arch/arm/include/uapi/asm/hwcap.h
+++ b/arch/arm/include/uapi/asm/hwcap.h
@@ -27,5 +27,10 @@
 #define HWCAP_IDIV	(HWCAP_IDIVA | HWCAP_IDIVT)
 #define HWCAP_LPAE	(1 << 20)
 #define HWCAP_EVTSTRM	(1 << 21)
+#define HWCAP_AES	(1 << 22)
+#define HWCAP_PMULL	(1 << 23)
+#define HWCAP_SHA1	(1 << 24)
+#define HWCAP_SHA2	(1 << 25)
+#define HWCAP_CRC32	(1 << 26)
 
 #endif /* _UAPI__ASMARM_HWCAP_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6a1b8a8..57e6b5e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -990,6 +990,11 @@ static const char *hwcap_str[] = {
 	"vfpd32",
 	"lpae",
 	"evtstrm",
+	"aes",
+	"pmull",
+	"sha1",
+	"sha2",
+	"crc32",
 	NULL
 };
 
-- 
1.8.3.2
