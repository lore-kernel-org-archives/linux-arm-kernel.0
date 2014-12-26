From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 26 Dec 2014 13:34:54 +0100
Subject: [PATCH 3/3] ARM: dts: OMAP34xx/36xx: Add temperature sensor
In-Reply-To: <1419597294-21487-1-git-send-email-sre@kernel.org>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
Message-ID: <1419597294-21487-4-git-send-email-sre@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP34xx and OMAP36xx processors contain a register in the
syscon area, which can be used to determine the SoCs temperature.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap34xx.dtsi | 7 +++++++
 arch/arm/boot/dts/omap36xx.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 3819c1e..64679ee 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -38,6 +38,13 @@
 			pinctrl-single,function-mask = <0xff1f>;
 		};
 	};
+
+	omap3_temperature_sensor: temperature-sensor {
+		compatible = "ti,omap34xx-temperature-sensor";
+		syscon = <&omap3_scm_general>;
+		clocks = <&ts_fck>;
+		clock-names = "fck";
+	};
 };
 
 &ssi {
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 541704a..be9ee1d 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -70,6 +70,13 @@
 			pinctrl-single,function-mask = <0xff1f>;
 		};
 	};
+
+	omap3_temperature_sensor: temperature-sensor {
+		compatible = "ti,omap36xx-temperature-sensor";
+		syscon = <&omap3_scm_general>;
+		clocks = <&ts_fck>;
+		clock-names = "fck";
+	};
 };
 
 /* OMAP3630 needs dss_96m_fck for VENC */
-- 
2.1.3
