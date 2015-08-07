From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  7 Aug 2015 15:34:46 +0200
Subject: [PATCH 2/2] ARM: Wire up mlock2 syscall
In-Reply-To: <1438954486-28286-1-git-send-email-thierry.reding@gmail.com>
References: <1438954486-28286-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1438954486-28286-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/include/uapi/asm/unistd.h | 1 +
 arch/arm/kernel/calls.S            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index ca96eca3453c..977831f49576 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -415,6 +415,7 @@
 #define __NR_bpf			(__NR_SYSCALL_BASE+386)
 #define __NR_execveat			(__NR_SYSCALL_BASE+387)
 #define __NR_userfaultfd		(__NR_SYSCALL_BASE+388)
+#define __NR_mlock2			(__NR_SYSCALL_BASE+389)
 
 /*
  * The following SWIs are ARM private.
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 84c405670ff0..e9705ba5a1ff 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -398,6 +398,7 @@
 		CALL(sys_bpf)
 		CALL(sys_execveat)
 		CALL(sys_userfaultfd)
+		CALL(sys_mlock2)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
-- 
2.4.5
