From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:19:53 +0000
Subject: [PATCH 64/75] ARM: l2c: realview: improve commentry about the L2
 cache requirements
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYZV-0007HB-Oc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add better commentry about the L2 cache requirements on these platforms.
Unfortunately, the auxiliary control register is not pre-set to indicate
the correct cache parameters, so we have to manually program these.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/realview_eb.c     | 9 +++++++--
 arch/arm/mach-realview/realview_pb1176.c | 8 +++++++-
 arch/arm/mach-realview/realview_pb11mp.c | 9 +++++++--
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index c85ddb2a0ad0..b575895037b8 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -442,8 +442,13 @@ static void __init realview_eb_init(void)
 		realview_eb11mp_fixup();
 
 #ifdef CONFIG_CACHE_L2X0
-		/* 1MB (128KB/way), 8-way associativity, evmon/parity/share enabled
-		 * Bits:  .... ...0 0111 1001 0000 .... .... .... */
+		/*
+		 * The PL220 needs to be manually configured as the hardware
+		 * doesn't report the correct sizes.
+		 * 1MB (128KB/way), 8-way associativity, event monitor and
+		 * parity enabled, ignore share bit, no force write allocate
+		 * Bits:  .... ...0 0111 1001 0000 .... .... ....
+		 */
 		l2x0_init(__io_address(REALVIEW_EB11MP_L220_BASE), 0x00790000, 0xfe000fff);
 #endif
 		platform_device_register(&pmu_device);
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index c5eade76461b..e3bddb5ab10f 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -355,7 +355,13 @@ static void __init realview_pb1176_init(void)
 	int i;
 
 #ifdef CONFIG_CACHE_L2X0
-	/* 128Kb (16Kb/way) 8-way associativity. evmon/parity/share enabled. */
+	/*
+	 * The PL220 needs to be manually configured as the hardware
+	 * doesn't report the correct sizes.
+	 * 128kB (16kB/way), 8-way associativity, event monitor and
+	 * parity enabled, ignore share bit, no force write allocate
+	 * Bits:  .... ...0 0111 0011 0000 .... .... ....
+	 */
 	l2x0_init(__io_address(REALVIEW_PB1176_L220_BASE), 0x00730000, 0xfe000fff);
 #endif
 
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index f4b0962578fe..101deaf2630b 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -337,8 +337,13 @@ static void __init realview_pb11mp_init(void)
 	int i;
 
 #ifdef CONFIG_CACHE_L2X0
-	/* 1MB (128KB/way), 8-way associativity, evmon/parity/share enabled
-	 * Bits:  .... ...0 0111 1001 0000 .... .... .... */
+	/*
+	 * The PL220 needs to be manually configured as the hardware
+	 * doesn't report the correct sizes.
+	 * 1MB (128KB/way), 8-way associativity, event monitor and
+	 * parity enabled, ignore share bit, no force write allocate
+	 * Bits:  .... ...0 0111 1001 0000 .... .... ....
+	 */
 	l2x0_init(__io_address(REALVIEW_TC11MP_L220_BASE), 0x00790000, 0xfe000fff);
 #endif
 
-- 
1.8.3.1
