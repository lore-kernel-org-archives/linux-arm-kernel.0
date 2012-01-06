From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 6 Jan 2012 11:25:40 +0800
Subject: [PATCH 3/6] arm/dts: imx6q-sabrelite: add 2P5V and 3P3V regulators
In-Reply-To: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1325820343-11875-4-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 08d920d..3f4b45e 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -46,4 +46,24 @@
 			};
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_2P5V: regulator-2P5V {
+			compatible = "regulator-fixed";
+			regulator-name = "2P5V";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
+
+		reg_3P3V: regulator-3P3V {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
 };
-- 
1.7.5.4
