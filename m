From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Tue, 10 Jun 2014 11:34:19 +0900
Subject: [PATCH v2] ARM: shmobile: koelsch: Add support HSCIF1
Message-ID: <1402367659-21117-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Koelsch can use HSCIF1 insetead of SCIF1 as serial port. But if we want to
use, we will need to disable the GPIO key and remodeling of the board.
Therefore status of hscif1 does not set the "okay".

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 V2: Remove hscif1_clk from renesas,groups. This pin does not use.
 
 arch/arm/boot/dts/r8a7791-koelsch.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index b2e6616..0992673 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -22,6 +22,7 @@
 	aliases {
 		serial6 = &scif0;
 		serial7 = &scif1;
+		serial16 = &hscif1;
 	};
 
 	chosen {
@@ -258,6 +259,11 @@
 		renesas,function = "scif1";
 	};
 
+	hscif1_pins: serial2 {
+		renesas,groups = "hscif1_data", "hscif1_ctrl";
+		renesas,function = "hscif1";
+	};
+
 	ether_pins: ether {
 		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
 		renesas,function = "eth";
@@ -334,6 +340,11 @@
 	status = "okay";
 };
 
+&hscif1 {
+	pinctrl-0 = <&hscif1_pins>;
+	pinctrl-names = "default";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
-- 
2.0.0
