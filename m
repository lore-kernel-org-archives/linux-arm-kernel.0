From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 10:32:39 +0800
Subject: [PATCH 6/6] arm/shark: fix debug macro compilation failure
In-Reply-To: <1279074759.517724.734812272398.0.gpush@pororo>
Message-ID: <1279074759.519965.460792163785.6.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need a waituart macro.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/mach-shark/include/mach/debug-macro.S |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shark/include/mach/debug-macro.S b/arch/arm/mach-shark/include/mach/debug-macro.S
index 269281f..3c46860 100644
--- a/arch/arm/mach-shark/include/mach/debug-macro.S
+++ b/arch/arm/mach-shark/include/mach/debug-macro.S
@@ -21,6 +21,9 @@
 		strb	\rd, [\rx]
 		.endm
 
+		.macro waituart,rd,rx
+		.endm
+
 		.macro	busyuart,rd,rx
 		mov	\rd, #0
 1001:		add	\rd, \rd, #1
@@ -28,3 +31,5 @@
 		bne	1001b
 		.endm
 
+
+
