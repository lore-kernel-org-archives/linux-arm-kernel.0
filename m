From: tyler@opensourcefoundries.com (tyler at opensourcefoundries.com)
Date: Thu, 30 Nov 2017 12:14:33 -0800
Subject: [PATCH 7/8] ARM: dts: imx7s: add usb hsic phy domain
In-Reply-To: <20171130201434.14122-1-tyler@opensourcefoundries.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
Message-ID: <20171130201434.14122-8-tyler@opensourcefoundries.com>
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
