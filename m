From: will.deacon@arm.com (Will Deacon)
Date: Fri,  8 Jun 2012 16:12:18 +0100
Subject: [PATCH v2 1/4] audit: arm: only allow syscall auditing for pure EABI
 userspace
In-Reply-To: <1339168341-29850-1-git-send-email-will.deacon@arm.com>
References: <1339168341-29850-1-git-send-email-will.deacon@arm.com>
Message-ID: <1339168341-29850-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audit tools support only EABI userspace and, since there are no
AUDIT_ARCH_* defines for the ARM OABI, it makes sense to allow syscall
auditing on ARM only for EABI at the moment.

Cc: Eric Paris <eparis@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 init/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index d07dcf9..b3f55f1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -357,7 +357,7 @@ config AUDIT
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || ARM)
+	depends on AUDIT && (X86 || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT))
 	default y if SECURITY_SELINUX
 	help
 	  Enable low-overhead system-call auditing infrastructure that
-- 
1.7.4.1
