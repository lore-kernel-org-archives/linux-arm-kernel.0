From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 13 Sep 2018 23:35:44 +0530
Subject: [PATCH v3 3/4] arm64: boot: dts: rockchip: Add support for Rock960
 board
In-Reply-To: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
References: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180913180545.29756-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree support for Rock960 board, one of the Consumer Edition
boards of the 96Boards family. This board support utilizes the common
Rock960 family board support that includes Ficus 96Board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-rock960.dts      | 52 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index b0092d95b574..57c0d76458e6 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
new file mode 100644
index 000000000000..3c3308daec98
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Linaro Ltd.
+ */
+
+/dts-v1/;
+#include "rk3399-rock960.dtsi"
+
+/ {
+	model = "96boards Rock960";
+	compatible = "vamrs,rock960", "rockchip,rk3399";
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&pcie0 {
+	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
+};
+
+&pinctrl {
+	pcie {
+		pcie_drv: pcie-drv {
+			rockchip,pins =
+				<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+	};
+
+	usb2 {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins =
+				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&usbdrd_dwc3_0 {
+	dr_mode = "otg";
+};
+
+&usbdrd_dwc3_1 {
+	dr_mode = "host";
+};
+
+&vcc3v3_pcie {
+	gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+};
+
+&vcc5v0_host {
+	gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
+};
-- 
2.17.1
