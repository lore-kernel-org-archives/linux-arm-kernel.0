From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 20:01:18 +0000
Subject: [PATCH 20/20] ARM: sa11x0: don't static map sa1111
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPJu-00045E-18@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sa1111 support will ioremap() the device; there is no need for
platforms to setup a static mapping for this.  Remove the static
mapping for this device from badge4, jornada720 and neponset.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/badge4.c     |    5 -----
 arch/arm/mach-sa1100/jornada720.c |    5 -----
 arch/arm/mach-sa1100/neponset.c   |    5 -----
 3 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 8fb80f0..645ffa1 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -285,11 +285,6 @@ static struct map_desc badge4_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(0x10000000),
 		.length		= 0x00100000,
 		.type		= MT_DEVICE
-	}, {	/* SA-1111      */
-		.virtual	= 0xf4000000,
-		.pfn		= __phys_to_pfn(0x48000000),
-		.length		= 0x00100000,
-		.type		= MT_DEVICE
 	}
 };
 
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index dcd6d02..5d2ceb4 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -285,11 +285,6 @@ static struct map_desc jornada720_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(EPSONFBSTART),
 		.length		= EPSONFBLEN,
 		.type		= MT_DEVICE
-	}, {	/* SA-1111 */
-		.virtual	= 0xf4000000,
-		.pfn		= __phys_to_pfn(SA1111REGSTART),
-		.length		= SA1111REGLEN,
-		.type		= MT_DEVICE
 	}
 };
 
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index b40a719..290afed 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -333,11 +333,6 @@ static struct map_desc neponset_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(0x10000000),
 		.length		= SZ_1M,
 		.type		= MT_DEVICE
-	}, {	/* SA-1111 */
-		.virtual	=  0xf4000000,
-		.pfn		= __phys_to_pfn(0x40000000),
-		.length		= SZ_1M,
-		.type		= MT_DEVICE
 	}
 };
 
-- 
1.7.4.4
