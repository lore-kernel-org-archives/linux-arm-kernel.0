From: tyler@opensourcefoundries.com (tyler at opensourcefoundries.com)
Date: Tue,  5 Dec 2017 14:27:07 -0800
Subject: [PATCH v1 6/6] ARM: dts: imx7s: add usb hsic phy domain
In-Reply-To: <20171205222707.11302-1-tyler@opensourcefoundries.com>
References: <20171205222707.11302-1-tyler@opensourcefoundries.com>
Message-ID: <20171205222707.11302-7-tyler@opensourcefoundries.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler@opensourcefoundries.com>

The GPCv2 driver should control the MIPI, PCIe,
and USB HSIC PHY regulators. Add the USB HSIC
power domain to the GPC node.

Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 151ab34..9626a3e 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -602,6 +602,12 @@
 						reg = <IMX7_POWER_DOMAIN_PCIE_PHY>;
 						power-supply = <&reg_1p0d>;
 					};
+					pgc_usb_hsic_phy: pgc-usb-hsic-phy-domain {
+						#power-domain-cells = <0>;
+
+						reg = <IMX7_POWER_DOMAIN_USB_HSIC_PHY>;
+						power-supply = <&reg_1p2>;
+					};
 				};
 			};
 		};
-- 
2.9.3
