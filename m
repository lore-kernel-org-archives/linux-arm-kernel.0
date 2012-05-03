From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 May 2012 18:42:57 +0100
Subject: [PATCH 3/6] audit: arm: only allow syscall auditing for pure EABI
 userspace
In-Reply-To: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
References: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
Message-ID: <1336066980-24000-4-git-send-email-will.deacon@arm.com>
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
index 6cfd71d..5e83be4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -355,7 +355,7 @@ config AUDIT
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || ARM)
+	depends on AUDIT && (X86 || PPC || S390 || IA64 || UML || SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT))
 	default y if SECURITY_SELINUX
 	help
 	  Enable low-overhead system-call auditing infrastructure that
-- 
1.7.4.1
