From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:12 -0400
Subject: [PATCH 27/52] ARM: mach-netx: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-27-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-netx/nxdb500.c    |    2 +-
 arch/arm/mach-netx/nxdkn.c      |    2 +-
 arch/arm/mach-netx/nxeb500hmi.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-netx/nxdb500.c b/arch/arm/mach-netx/nxdb500.c
index ca8b203..90903dd 100644
--- a/arch/arm/mach-netx/nxdb500.c
+++ b/arch/arm/mach-netx/nxdb500.c
@@ -200,7 +200,7 @@ static void __init nxdb500_init(void)
 }
 
 MACHINE_START(NXDB500, "Hilscher nxdb500")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.map_io		= netx_map_io,
 	.init_irq	= netx_init_irq,
 	.timer		= &netx_timer,
diff --git a/arch/arm/mach-netx/nxdkn.c b/arch/arm/mach-netx/nxdkn.c
index d775cbe..c63384a 100644
--- a/arch/arm/mach-netx/nxdkn.c
+++ b/arch/arm/mach-netx/nxdkn.c
@@ -93,7 +93,7 @@ static void __init nxdkn_init(void)
 }
 
 MACHINE_START(NXDKN, "Hilscher nxdkn")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.map_io		= netx_map_io,
 	.init_irq	= netx_init_irq,
 	.timer		= &netx_timer,
diff --git a/arch/arm/mach-netx/nxeb500hmi.c b/arch/arm/mach-netx/nxeb500hmi.c
index de369cd..8f548ec 100644
--- a/arch/arm/mach-netx/nxeb500hmi.c
+++ b/arch/arm/mach-netx/nxeb500hmi.c
@@ -177,7 +177,7 @@ static void __init nxeb500hmi_init(void)
 }
 
 MACHINE_START(NXEB500HMI, "Hilscher nxeb500hmi")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.map_io		= netx_map_io,
 	.init_irq	= netx_init_irq,
 	.timer		= &netx_timer,
-- 
1.7.4
