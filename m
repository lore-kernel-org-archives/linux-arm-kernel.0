From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2012 10:57:08 +0100
Subject: [PATCH 5/8] ARM: ux500: Add node for the MMC GPIO regulator
In-Reply-To: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
References: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1351159031-25391-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a very simple mechanism to change and SDI's voltage which
consists of toggling some GPIOs. This scenario can be better handled
if we convert it to a GPIO regulator. This patch provides one which
can be read from Device Tree.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 07a085b..536df5d 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -614,5 +614,19 @@
 			ranges = <0 0x50000000 0x4000000>;
 			status = "disabled";
 		};
+
+		vmmci: regulator-gpio {
+			compatible = "regulator-gpio";
+
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2600000>;
+			regulator-name = "mmci-reg";
+			regulator-type = "voltage";
+
+			gpios = <&tc3589x_gpio 18 0x4>;
+			gpio-enable = <&tc3589x_gpio 17 0x4>;
+			states = <1800000 0x1
+				  2900000 0x0>;
+		};
 	};
 };
-- 
1.7.9.5
