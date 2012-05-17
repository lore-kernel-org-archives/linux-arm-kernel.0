From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:23 +0100
Subject: [PATCH 18/18] ARM: ux500: Add support for input/ponkey into the
 db8500's Device Tree
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-19-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index e14001b..076831c 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -215,6 +215,13 @@
 					vddadc-supply = <&ab8500_ldo_tvout_reg>;
 				};
 
+				ab8500-ponkey {
+					compatible = "stericsson,ab8500-ponkey";
+					interrupts = <0 6 0x4
+						      0 7 0x4>;
+					interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
+				};
+
 				ab8500-regulators {
 					compatible = "stericsson,ab8500-regulator";
 
-- 
1.7.9.5
