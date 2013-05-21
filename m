From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 21 May 2013 14:14:36 +0200
Subject: [PATCH v4 15/21] ARM: shmobile: armadillo-reference: Move st1232
 reset GPIO to DT
In-Reply-To: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1369138482-5871-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference the st1232 reset GPIO from the device tree and remove it from
board code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts  | 1 +
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index a6c6606..a037776 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -43,6 +43,7 @@
 		interrupts = <2 0>; /* IRQ10: hwirq 2 on irqpin1 */
 		pinctrl-0 = <&st1232_pins>;
 		pinctrl-names = "default";
+		gpios = <&pfc 166 1>;
 	};
 };
 
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 4ddd299..002d8d3 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -158,7 +158,6 @@ clock_error:
  */
 static void __init eva_init(void)
 {
-
 	r8a7740_clock_init(MD_CK0 | MD_CK2);
 	eva_clock_init();
 
@@ -171,12 +170,6 @@ static void __init eva_init(void)
 
 	r8a7740_add_standard_devices_dt();
 
-	/*
-	 * Touchscreen
-	 * TODO: Move reset GPIO over to .dts when we can reference it
-	 */
-	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
-
 	r8a7740_pm_init();
 }
 
-- 
1.8.1.5
