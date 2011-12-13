From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 13 Dec 2011 15:49:35 +0530
Subject: [PATCH v2 3/3] omap4: panda: Pass regulator data from dt
In-Reply-To: <1323771575-3550-1-git-send-email-rnayak@ti.com>
References: <1323771575-3550-1-git-send-email-rnayak@ti.com>
Message-ID: <1323771575-3550-4-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the adjustable voltage regulator information for
omap4panda board from device tree.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index b66bcd6..f6cc48a 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -40,6 +40,30 @@
 			compatible = "ti,twl4030-rtc";
 			interrupts = <11>;
 		};
+
+		vaux2: regulator at 0 {
+			compatible = "ti,twl6030-vaux2","ti,twl6030";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		vaux3: regulator at 1 {
+			compatible = "ti,twl6030-vaux3","ti,twl6030";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		vmmc: regulator at 2 {
+			compatible = "ti,twl6030-vmmc","ti,twl6030";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		vpp: regulator at 3 {
+			compatible = "ti,twl6030-vpp","ti,twl6030";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2500000>;
+		};
 	};
 };
 
-- 
1.7.1
