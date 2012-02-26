From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 26 Feb 2012 16:47:42 +0300
Subject: [PATCH 3/3] ARM: PXA27x: Zipit Z2: disable wake on GPIO0
In-Reply-To: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1330264062-5750-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't want machine to wake up on AC state change

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 0fb5617..bb672ee 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -746,6 +746,13 @@ static void z2_power_off(void)
 #define z2_power_off   NULL
 #endif
 
+static void __init z2_map_io(void)
+{
+	pxa27x_map_io();
+
+	PWER &= ~(1 << 0);
+}
+
 /******************************************************************************
  * Machine init
  ******************************************************************************/
@@ -776,7 +783,7 @@ static void __init z2_init(void)
 
 MACHINE_START(ZIPIT2, "Zipit Z2")
 	.atag_offset	= 0x100,
-	.map_io		= pxa27x_map_io,
+	.map_io		= z2_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
-- 
1.7.9.2
