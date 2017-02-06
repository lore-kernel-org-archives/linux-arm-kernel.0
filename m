From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  6 Feb 2017 16:24:30 +0000
Subject: [PATCH 2/7] include: pe.h: add some missing definitions
In-Reply-To: <1486398275-3966-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1486398275-3966-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1486398275-3966-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Add the missing IMAGE_FILE_MACHINE_ARM64 and IMAGE_DEBUG_TYPE_CODEVIEW
definitions.

We'll need them for the arm64 EFI stub...

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/pe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index a8a594117df3..143ce75be5f0 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -34,6 +34,7 @@
 #define	IMAGE_FILE_MACHINE_AMD64	0x8664
 #define	IMAGE_FILE_MACHINE_ARM		0x01c0
 #define	IMAGE_FILE_MACHINE_ARMV7	0x01c4
+#define	IMAGE_FILE_MACHINE_ARM64	0xaa64
 #define	IMAGE_FILE_MACHINE_EBC		0x0ebc
 #define	IMAGE_FILE_MACHINE_I386		0x014c
 #define	IMAGE_FILE_MACHINE_IA64		0x0200
@@ -141,6 +142,8 @@
 #define IMAGE_SCN_MEM_READ	0x40000000 /* readable */
 #define IMAGE_SCN_MEM_WRITE	0x80000000 /* writeable */
 
+#define IMAGE_DEBUG_TYPE_CODEVIEW	2
+
 #ifndef __ASSEMBLY__
 
 struct mz_hdr {
-- 
2.7.4
