From: nkela@cisco.com (Nikunj Kela)
Date: Mon,  2 Jul 2018 14:04:51 -0700
Subject: [PATCH 2/2] arm64: add support for 43bit physical address
Message-ID: <20180702210451.16057-2-nkela@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for 43bit physical address. Additionally,
this patch adds support for 27bit section size. This is useful in
reducing kernel memory usage. One usecase is in kdump kernel.

Cc: xe-kernel at external.cisco.com
Cc: Nikunj Kela <nkela@cisco.com>
Signed-off-by: Nikunj Kela <nkela@cisco.com>
---
 arch/arm64/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index edf327f..76d0bfb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -665,6 +665,9 @@ choice
 	  Choose the maximum physical address range that the kernel will
 	  support.
 
+config ARM64_PA_BITS_43
+	bool "43-bit"
+
 config ARM64_PA_BITS_48
 	bool "48-bit"
 
@@ -684,6 +687,7 @@ endchoice
 
 config ARM64_PA_BITS
 	int
+	default 43 if ARM64_PA_BITS_43
 	default 48 if ARM64_PA_BITS_48
 	default 52 if ARM64_PA_BITS_52
 
@@ -693,6 +697,9 @@ choice
 	help
 	  Choose the maximum amount of memory in a section.
 
+config ARM64_SEC_BITS_27
+	bool "27-bit"
+
 config ARM64_SEC_BITS_30
 	bool "30-bit"
 
@@ -700,6 +707,7 @@ endchoice
 
 config ARM64_SEC_BITS
 	int
+	default 27 if ARM64_SEC_BITS_27
 	default 30 if ARM64_SEC_BITS_30
 
 config CPU_BIG_ENDIAN
-- 
2.5.0
