From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 27 Sep 2011 15:42:50 +0530
Subject: [PATCH 7/9] omap4: panda: Pass regulator data from DT
In-Reply-To: <1317118372-17052-1-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Message-ID: <1317118372-17052-8-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the fixed and adjustable voltage regulator information for
omap4panda board from device tree.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   54 +++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 2c6ce2b..045dbfc 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -48,6 +48,60 @@
 			compatible = "ti,twl4030-rtc";
 			interrupts = <11>;
 		};
+
+		vwl1271: fixedregulator at 0 {
+			compatible = "regulator-fixed";
+			regulator-fixed-supply = "vwl1271";
+			regulator-fixed-microvolts = <1800000>;
+			regulator-fixed-gpio = <43>;
+			regulator-fixed-startup-delay = <70000>;
+			regulator-fixed-enable-high;
+			regulator-fixed-enabled-at-boot;
+		};
+
+		vaux2: regulator at 0 {
+			compatible = "ti,twl6030-vaux2","ti,twl6030";
+			regulator-min-uV = <1200000>;
+			regulator-max-uV = <2800000>;
+			regulator-mode-normal;
+			regulator-mode-standby;
+			regulator-change-mode;
+			regulator-change-status;
+			regulator-change-voltage;
+		};
+
+		vaux3: regulator at 1 {
+			compatible = "ti,twl6030-vaux3","ti,twl6030";
+			regulator-min-uV = <1000000>;
+			regulator-max-uV = <3000000>;
+			regulator-mode-normal;
+			regulator-mode-standby;
+			regulator-change-mode;
+			regulator-change-status;
+			regulator-change-voltage;
+		};
+
+		vmmc: regulator at 2 {
+			compatible = "ti,twl6030-vmmc","ti,twl6030";
+			regulator-min-uV = <1200000>;
+			regulator-max-uV = <3000000>;
+			regulator-mode-normal;
+			regulator-mode-standby;
+			regulator-change-mode;
+			regulator-change-status;
+			regulator-change-voltage;
+		};
+
+		vpp: regulator at 3 {
+			compatible = "ti,twl6030-vpp","ti,twl6030";
+			regulator-min-uV = <1800000>;
+			regulator-max-uV = <2500000>;
+			regulator-mode-normal;
+			regulator-mode-standby;
+			regulator-change-mode;
+			regulator-change-status;
+			regulator-change-voltage;
+		};
 	};
 };
 
-- 
1.7.1
