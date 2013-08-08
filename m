From: wni@nvidia.com (Wei Ni)
Date: Thu, 8 Aug 2013 14:56:30 +0800
Subject: [PATCH v2 2/3] ARM: dt: t114 dalmore: add dt entry for nct1008
In-Reply-To: <1375944991-29182-1-git-send-email-wni@nvidia.com>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
Message-ID: <1375944991-29182-3-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable thermal sensor nct1008 for t114 dalmore.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index b5a42f0..9d4d2b2 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -738,6 +738,14 @@
 			realtek,ldo1-en-gpios =
 				<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 		};
+
+		nct1008 {
+			compatible = "onnn,nct1008";
+			reg = <0x4c>;
+			vdd-supply = <&palmas_ldo6_reg>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
+		};
 	};
 
 	i2c at 7000d000 {
@@ -945,7 +953,7 @@
 						regulator-max-microvolt = <1800000>;
 					};
 
-					ldo6 {
+					palmas_ldo6_reg: ldo6 {
 						regulator-name = "vdd-sensor-2v85";
 						regulator-min-microvolt = <2850000>;
 						regulator-max-microvolt = <2850000>;
-- 
1.7.9.5
