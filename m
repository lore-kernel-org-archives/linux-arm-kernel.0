From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Jun 2013 17:11:19 +0100
Subject: [PATCH 01/10] ARM: ux500: Add Device Tree nodes for AB8500 External
 regulators
In-Reply-To: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370621488-18130-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AB8500 has 3 external regulators which are used to control outside
voltage sources. Some of the core AB8500 use these external regulators
as a supply, so they must be obtainable via Device Tree.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index a082f0b..ea87fac 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -452,6 +452,33 @@
 					stericsson,earpeice-cmv = <950>; /* Units in mV. */
 				};
 
+				ext_regulators: ab8500-ext-regulators {
+					compatible = "stericsson,ab8500-ext-regulator";
+
+					ab8500_ext1_reg: ab8500_ext1 {
+						regulator-compatible = "ab8500_ext1";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-boot-on;
+						regulator-always-on;
+					};
+
+					ab8500_ext2_reg: ab8500_ext2 {
+						regulator-compatible = "ab8500_ext2";
+						regulator-min-microvolt = <1360000>;
+						regulator-max-microvolt = <1360000>;
+						regulator-boot-on;
+						regulator-always-on;
+					};
+
+					ab8500_ext3_reg: ab8500_ext3 {
+						regulator-compatible = "ab8500_ext3";
+						regulator-min-microvolt = <3400000>;
+						regulator-max-microvolt = <3400000>;
+						regulator-boot-on;
+					};
+				};
+
 				ab8500-regulators {
 					compatible = "stericsson,ab8500-regulator";
 
-- 
1.7.10.4
