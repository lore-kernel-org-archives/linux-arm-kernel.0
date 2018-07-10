From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 10 Jul 2018 10:47:32 -0300
Subject: [PATCH v2 2/6] ARM: dts: imx51: Add PMU support
In-Reply-To: <1531230456-27717-1-git-send-email-fabio.estevam@nxp.com>
References: <1531230456-27717-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1531230456-27717-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PMU support in the device tree.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Newly introduced in this series.

 arch/arm/boot/dts/imx51.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 66e4187..113ddbc 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -93,6 +93,12 @@
 		};
 	};
 
+	pmu: pmu {
+		compatible = "arm,cortex-a8-pmu";
+		interrupt-parent = <&tzic>;
+		interrupts = <77>;
+	};
+
 	usbphy0: usbphy0 {
 		compatible = "usb-nop-xceiv";
 		clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
-- 
2.7.4
