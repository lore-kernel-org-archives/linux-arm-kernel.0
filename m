From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 12 Mar 2012 20:32:40 +0530
Subject: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and board data
In-Reply-To: <1331564560-23276-1-git-send-email-rnayak@ti.com>
References: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Message-ID: <1331564560-23276-5-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add omap mmc related device tree data for OMAP3.
Currenly limited to only omap3-beagle board.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   14 ++++++++++++++
 arch/arm/boot/dts/omap3.dtsi       |   16 ++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 714ba5d..5cf67d1 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -47,3 +47,17 @@
 		reg = <0x50>;
 	};
 };
+
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
+	vmmc_aux-supply = <&vsim>;
+	ti,bus-width = <8>;
+};
+
+&mmc2 {
+	status = "disable";
+};
+
+&mmc3 {
+	status = "disable";
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index ca37ba5..3892e34 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -113,5 +113,21 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
 		};
+
+		mmc1: mmc at 1 {
+			compatible = "ti,omap3-hsmmc";
+			ti,hwmods = "mmc1";
+			ti,dual-volt;
+		};
+
+		mmc2: mmc at 2 {
+			compatible = "ti,omap3-hsmmc";
+			ti,hwmods = "mmc2";
+		};
+
+		mmc3: mmc at 3 {
+			compatible = "ti,omap3-hsmmc";
+			ti,hwmods = "mmc3";
+		};
 	};
 };
-- 
1.7.1
