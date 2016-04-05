From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 6 Apr 2016 01:08:30 +0300
Subject: [PATCH 08/25] arm64: ilp32: add documentation on the ILP32 ABI for
 ARM64
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1459894127-17698-9-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on Andrew Pinski's patch-series.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 Documentation/arm64/ilp32.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/arm64/ilp32.txt

diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
new file mode 100644
index 0000000..15b5c83
--- /dev/null
+++ b/Documentation/arm64/ilp32.txt
@@ -0,0 +1,13 @@
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
+as compat syscalls expects, and struct ilp32_sigframe, to handle
+AARCH64 register set and 32-bit userspace register representation.
+
-- 
2.5.0
