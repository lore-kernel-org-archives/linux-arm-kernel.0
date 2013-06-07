From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Jun 2013 17:11:20 +0100
Subject: [PATCH 02/10] ARM: ux500: Provide a supply name for the AB8500 AUX
 regulators to use
In-Reply-To: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370621488-18130-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AB8500 AUX regulators are supplied by EXT3 on some boards. This supply
phandle lookup will enable the regulator core to search for and locate
the EXT3 supply at registration time.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index ea87fac..be63293 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -481,6 +481,7 @@
 
 				ab8500-regulators {
 					compatible = "stericsson,ab8500-regulator";
+					vin-supply = <&ab8500_ext3_reg>;
 
 					// supplies to the display/camera
 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
-- 
1.7.10.4
