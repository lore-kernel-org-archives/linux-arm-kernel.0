From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 01 Sep 2010 09:07:50 +0800
Subject: [PATCH 1/3] arm/debug: consolidate addruart macros for
	CONFIG_DEBUG_ICEDCC
In-Reply-To: <1283303270.565454.673065645961.0.gpush@pororo>
Message-ID: <1283303270.565838.916963744519.1.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have the same (empty) macro for all IDEDCC flavours, so consolidate
it to one.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/kernel/debug.S |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index a38b487..f913952 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -22,11 +22,11 @@
 #if defined(CONFIG_DEBUG_ICEDCC)
 		@@ debug using ARM EmbeddedICE DCC channel
 
-#if defined(CONFIG_CPU_V6)
-
 		.macro	addruart, rx, tmp
 		.endm
 
+#if defined(CONFIG_CPU_V6)
+
 		.macro	senduart, rd, rx
 		mcr	p14, 0, \rd, c0, c5, 0
 		.endm
@@ -51,9 +51,6 @@
 
 #elif defined(CONFIG_CPU_V7)
 
-		.macro	addruart, rx, tmp
-		.endm
-
 		.macro	senduart, rd, rx
 		mcr	p14, 0, \rd, c0, c5, 0
 		.endm
@@ -71,9 +68,6 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 
 #elif defined(CONFIG_CPU_XSCALE)
 
-		.macro	addruart, rx, tmp
-		.endm
-
 		.macro	senduart, rd, rx
 		mcr	p14, 0, \rd, c8, c0, 0
 		.endm
@@ -98,9 +92,6 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 
 #else
 
-		.macro	addruart, rx, tmp
-		.endm
-
 		.macro	senduart, rd, rx
 		mcr	p14, 0, \rd, c1, c0, 0
 		.endm
