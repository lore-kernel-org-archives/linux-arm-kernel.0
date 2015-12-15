From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 16 Dec 2015 00:42:27 +0300
Subject: [PATCH v6 01/20] arm64: ilp32: add documentation on the ILP32 ABI for
 ARM64
In-Reply-To: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1450215766-14765-2-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on Andrew Pinski's patch-series.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 Documentation/arm64/ilp32.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/arm64/ilp32.txt

diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
new file mode 100644
index 0000000..ad3a48e
--- /dev/null
+++ b/Documentation/arm64/ilp32.txt
@@ -0,0 +1,17 @@
+ILP32 AARCH64 SYSCALL ABI
+=========================
+
+This document describes the ILP32 syscall ABI and where it differs
+from the generic compat linux syscall interface.
+
+Syscalls which normally would pass 64bit values as two arguments;
+now pass the 64bit value as one argument.
+
+struct rt_sigframe is redefined and contains struct compat_siginfo,
+as compat syscalls expects, and struct sigframe, taken from lp64 to
+handle AARCH64 register set.
+
+Syscalls openat and open_by_handle_at are as non-compat as, it's
+temporary solution. There is expected global refactoring for all
+platforms.
+
-- 
2.5.0
