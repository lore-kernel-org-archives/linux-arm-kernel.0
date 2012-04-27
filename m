From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 15:03:01 +0800
Subject: [PATCH 07/11] ARM: dts: imx6q-sabrelite: add audmux device
In-Reply-To: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1335510185-7906-8-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@linaro.org>

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    3 +++
 arch/arm/boot/dts/imx6q.dtsi          |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 7bd8855..02f93bc 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -52,6 +52,9 @@
 				status = "okay";
 			};
 
+			audmux at 021d8000 {
+				status = "okay";
+			};
 			uart2: uart at 021e8000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index da42fc0..7bf402e 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -596,7 +596,9 @@
 			};
 
 			audmux at 021d8000 {
+				compatible = "fsl,imx6q-audmux", "fsl,imx31-audmux";
 				reg = <0x021d8000 0x4000>;
+				status = "disabled";
 			};
 
 			mipi at 021dc000 { /* MIPI-CSI */
-- 
1.7.5.4
