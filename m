From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 May 2018 19:14:22 +0100
Subject: [PATCH] arm64: Kconfig: Enable LSE atomics by default
Message-ID: <1526926462-19214-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're seeing CPUs shipping with LSE atomics, default them to
'on' in Kconfig. CPUs without the instructions will continue to use
LDXR/STXR-based sequences, but they will be placed out-of-line by the
compiler.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4d98774cf3c7..3aed13626fd7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1051,6 +1051,7 @@ config ARM64_PAN
 
 config ARM64_LSE_ATOMICS
 	bool "Atomic instructions"
+	default y
 	help
 	  As part of the Large System Extensions, ARMv8.1 introduces new
 	  atomic instructions that are designed specifically to scale in
@@ -1059,7 +1060,8 @@ config ARM64_LSE_ATOMICS
 	  Say Y here to make use of these instructions for the in-kernel
 	  atomic routines. This incurs a small overhead on CPUs that do
 	  not support these instructions and requires the kernel to be
-	  built with binutils >= 2.25.
+	  built with binutils >= 2.25 in order for the new instructions
+	  to be used.
 
 config ARM64_VHE
 	bool "Enable support for Virtualization Host Extensions (VHE)"
-- 
2.1.4
