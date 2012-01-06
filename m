From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 6 Jan 2012 11:25:43 +0800
Subject: [PATCH 6/6] ARM: imx6q-sabrelite: add audmux support
In-Reply-To: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1325820343-11875-7-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- enable audmux in dts
- enable audmux in Kconfig

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++++
 arch/arm/boot/dts/imx6q.dtsi          |    2 ++
 arch/arm/mach-imx/Kconfig             |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 567b664..cae7151 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -41,6 +41,10 @@
 				status = "okay";
 			};
 
+			audmux at 021d8000 {
+				status = "okay";
+			};
+
 			uart2: uart at 021e8000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 263e8f3..12ed20c 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -527,7 +527,9 @@
 			};
 
 			audmux at 021d8000 {
+				compatible = "fsl,audmux-v2";
 				reg = <0x021d8000 0x4000>;
+				status = "disabled";
 			};
 
 			mipi at 021dc000 { /* MIPI-CSI */
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 6538972..67f0fe7 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -836,6 +836,7 @@ comment "i.MX6 family:"
 config SOC_IMX6Q
 	bool "i.MX6 Quad support"
 	select ARM_CPU_SUSPEND if PM
+	select ARCH_MXC_AUDMUX_V2
 	select ARM_GIC
 	select CACHE_L2X0
 	select CPU_V7
-- 
1.7.5.4
