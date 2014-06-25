From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 25 Jun 2014 23:30:16 +0530
Subject: [PATCH 6/8] ARM: dts: dra7: Add dt data for PCIe PHY control module
In-Reply-To: <1403719218-9484-1-git-send-email-kishon@ti.com>
References: <1403719218-9484-1-git-send-email-kishon@ti.com>
Message-ID: <1403719218-9484-7-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added dt data for PCIe PHY control module used by PCIe PHY.
The documention for this node can be found @ ../bindings/phy/ti-phy.txt

Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 34464cd..f029a90 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -827,6 +827,23 @@
 			ti,hwmods = "sata";
 		};
 
+		omap_control_pcie1phy: control-phy at 0x4a003c40 {
+			compatible = "ti,control-phy-pcie";
+			reg = <0x4a003c40 0x4>, <0x4a003c14 0x4>, <0x4a003c34 0x4>;
+			reg-names = "power", "control_sma", "pcie_pcs";
+			clocks = <&sys_clkin1>;
+			clock-names = "sysclk";
+		};
+
+		omap_control_pcie2phy: control-pcie at 0x4a003c44 {
+			compatible = "ti,control-phy-pcie";
+			reg = <0x4a003c44 0x4>, <0x4a003c14 0x4>, <0x4a003c34 0x4>;
+			reg-names = "power", "control_sma", "pcie_pcs";
+			clocks = <&sys_clkin1>;
+			clock-names = "sysclk";
+			status = "disabled";
+		};
+
 		omap_control_usb2phy1: control-phy at 4a002300 {
 			compatible = "ti,control-phy-usb2";
 			reg = <0x4a002300 0x4>;
-- 
1.7.9.5
