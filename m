From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 6 Jan 2012 11:25:41 +0800
Subject: [PATCH 4/6] arm/dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1325820343-11875-5-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 3f4b45e..567b664 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -44,6 +44,18 @@
 			uart2: uart at 021e8000 {
 				status = "okay";
 			};
+
+			i2c at 021a0000 { /* I2C1 */
+				status = "okay";
+				clock-frequency = <100000>;
+
+				codec: sgtl5000 at 0a {
+					compatible = "fsl,sgtl5000";
+					reg = <0x0a>;
+					VDDA-supply = <&reg_2P5V>;
+					VDDIO-supply = <&reg_3P3V>;
+				};
+			};
 		};
 	};
 
-- 
1.7.5.4
