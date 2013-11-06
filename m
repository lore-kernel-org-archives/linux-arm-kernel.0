From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  6 Nov 2013 19:25:43 +0900
Subject: [PATCH 1/4] audit: Enable arm64 support
In-Reply-To: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1383733546-2846-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 include/uapi/linux/audit.h |    2 ++
 init/Kconfig               |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 75cef3f..6f727c1 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -324,6 +324,8 @@ enum {
 /* distinguish syscall tables */
 #define __AUDIT_ARCH_64BIT 0x80000000
 #define __AUDIT_ARCH_LE	   0x40000000
+#define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_AARCH64EB	(EM_AARCH64|__AUDIT_ARCH_64BIT)
 #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARMEB	(EM_ARM)
diff --git a/init/Kconfig b/init/Kconfig
index 3ecd8a1..2220401 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -284,7 +284,7 @@ config AUDIT
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT))
+	depends on AUDIT && (X86 || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || ARM64)
 	default y if SECURITY_SELINUX
 	help
 	  Enable low-overhead system-call auditing infrastructure that
-- 
1.7.9.5
