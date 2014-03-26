From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 26 Mar 2014 19:27:49 +0530
Subject: [RFC PATCH 09/12] ARM: dts: dra7: Add dt data for PCIe PHY control
 module
In-Reply-To: <1395842272-15267-1-git-send-email-kishon@ti.com>
References: <1395842272-15267-1-git-send-email-kishon@ti.com>
Message-ID: <1395842272-15267-10-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added dt data for PCIe PHY control module used by PCIe PHY.
The documention for this node can be found @ ../bindings/phy/ti-phy.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index f3565ac..73c61d0 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -656,6 +656,14 @@
 			clock-names = "sysclk";
 		};
 
+		omap_control_pcie1phy: omap-control-pciephy at 0x4a003c40 {
+			compatible = "ti,control-phy-pipe3";
+			reg = <0x4a003c40 0x4>;
+			reg-names = "power";
+			clocks = <&sys_clkin1>;
+			clock-names = "sysclk";
+		};
+
 		/* OCP2SCP3 */
 		ocp2scp at 4a090000 {
 			compatible = "ti,omap-ocp2scp";
-- 
1.7.9.5
