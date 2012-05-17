From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:21 +0100
Subject: [PATCH 16/18] ARM: ux500: Add a ab8500-gpadc node to the db8500
 Device Tree
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides support for the ab8500-gpadc driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 0dc24e6..e14001b 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -207,6 +207,14 @@
 					compatible = "stericsson,ab8500-debug";
 				};
 
+				ab8500-gpadc {
+					compatible = "stericsson,ab8500-gpadc";
+					interrupts = <0 32 0x4
+						      0 39 0x4>;
+					interrupt-names = "HW_CONV_END", "SW_CONV_END";
+					vddadc-supply = <&ab8500_ldo_tvout_reg>;
+				};
+
 				ab8500-regulators {
 					compatible = "stericsson,ab8500-regulator";
 
-- 
1.7.9.5
