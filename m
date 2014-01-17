From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 17 Jan 2014 17:13:14 +0900
Subject: [PATCH v2 1/6] audit: Enable arm64 support
In-Reply-To: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
 <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1389946399-4525-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds AUDIT_ARCH_* identifiers for arm64(AArch64), and
makes CONFIG_AUDITSYSCALL selectable.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/uapi/linux/audit.h |    2 ++
 init/Kconfig               |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 44b05a0..e39635b 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -327,6 +327,8 @@ enum {
 /* distinguish syscall tables */
 #define __AUDIT_ARCH_64BIT 0x80000000
 #define __AUDIT_ARCH_LE	   0x40000000
+#define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_AARCH64EB	(EM_AARCH64|__AUDIT_ARCH_64BIT)
 #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARMEB	(EM_ARM)
diff --git a/init/Kconfig b/init/Kconfig
index 79383d3..3aae602 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -284,7 +284,7 @@ config AUDIT
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT))
+	depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || ARM64)
 	default y if SECURITY_SELINUX
 	help
 	  Enable low-overhead system-call auditing infrastructure that
-- 
1.7.9.5
