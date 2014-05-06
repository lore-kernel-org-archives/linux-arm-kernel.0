From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 6 May 2014 19:03:58 +0530
Subject: [PATCH 12/17] ARM: dts: dra7: Add dt data for PCIe PHY control module
In-Reply-To: <1399383244-14556-1-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
Message-ID: <1399383244-14556-13-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added dt data for PCIe PHY control module used by PCIe PHY.
The documention for this node can be found @ ../bindings/phy/ti-phy.txt

Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index f0ca46d..0d3c8c0 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -876,6 +876,14 @@
 			};
 		};
 
+		omap_control_pcie1phy: omap-control-pciephy at 0x4a003c40 {
+			compatible = "ti,control-phy-pcie";
+			reg = <0x4a003c40 0x4>, <0x4a003c14 0x4>, <0x4a003c34 0x4>;
+			reg-names = "power", "control_sma", "pcie_pcs";
+			clocks = <&sys_clkin1>;
+			clock-names = "sysclk";
+		};
+
 		/* OCP2SCP3 */
 		ocp2scp at 4a090000 {
 			compatible = "ti,omap-ocp2scp";
-- 
1.7.9.5
