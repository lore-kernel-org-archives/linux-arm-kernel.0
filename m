From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 15:29:46 +0800
Subject: [PATCH 6/6] arm/shark: fix debug macro compilation failure
In-Reply-To: <1279092586.619523.10182482328.0.gpush@pororo>
Message-ID: <1279092586.621335.388063245744.6.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need a waituart macro.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/mach-shark/include/mach/debug-macro.S |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shark/include/mach/debug-macro.S b/arch/arm/mach-shark/include/mach/debug-macro.S
index 50f071c..5ea24d4 100644
--- a/arch/arm/mach-shark/include/mach/debug-macro.S
+++ b/arch/arm/mach-shark/include/mach/debug-macro.S
@@ -20,6 +20,9 @@
 		strb	\rd, [\rx]
 		.endm
 
+		.macro waituart,rd,rx
+		.endm
+
 		.macro	busyuart,rd,rx
 		mov	\rd, #0
 1001:		add	\rd, \rd, #1
