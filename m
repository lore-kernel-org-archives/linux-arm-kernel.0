From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 23 Feb 2012 17:31:30 +0530
Subject: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and board data
In-Reply-To: <1329998490-27555-1-git-send-email-rnayak@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
Message-ID: <1329998490-27555-5-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add omap mmc related device tree data for OMAP3.
Currenly limited to only omap3-beagle board.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |    6 ++++++
 arch/arm/boot/dts/omap3.dtsi       |   26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 54556b1..c7b92e6 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -53,3 +53,9 @@
 		reg = <0x50>;
 	};
 };
+
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
+	vmmc_aux-supply = <&vsim>;
+	ti,bus-width = <8>;
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index ca37ba5..598467c 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -113,5 +113,31 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
 		};
+
+		mmc1: mmc at 1 {
+			compatible = "ti,omap2-hsmmc";
+			ti,hwmods = "mmc1";
+			ti,dual-volt;
+		};
+
+		mmc2: mmc at 2 {
+			compatible = "ti,omap2-hsmmc";
+			ti,hwmods = "mmc2";
+		};
+
+		mmc3: mmc at 3 {
+			compatible = "ti,omap2-hsmmc";
+			ti,hwmods = "mmc3";
+		};
+
+		mmc4: mmc at 4 {
+			compatible = "ti,omap2-hsmmc";
+			ti,hwmods = "mmc4";
+		};
+
+		mmc5: mmc at 5 {
+			compatible = "ti,omap2-hsmmc";
+			ti,hwmods = "mmc5";
+		};
 	};
 };
-- 
1.7.1
