From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 2 Feb 2012 10:12:02 +0800
Subject: [PATCH v2 3/9] ARM: dts: imx6q-sabrelite: add 2p5v and 3p3v regulators
In-Reply-To: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1328148728-32258-4-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 08d920d..cdc2ad6 100644
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
+		reg_2p5v: 2p5v {
+			compatible = "regulator-fixed";
+			regulator-name = "2P5V";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
+
+		reg_3p3v: 3p3v {
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
