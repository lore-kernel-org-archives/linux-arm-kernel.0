From: t.remmet@phytec.de (Teresa Remmet)
Date: Thu, 5 Jan 2017 15:50:50 +0100
Subject: [PATCH 5/6] ARM: dts: am335x-phycore-som: Update ethernet phy node
In-Reply-To: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
Message-ID: <1483627851-17996-6-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update ethernet phy0 node to use phy-handle now.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 08d1134..de91275 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -78,7 +78,7 @@
 };
 
 &cpsw_emac0 {
-	phy_id = <&davinci_mdio>, <0>;
+	phy-handle = <&phy0>;
 	phy-mode = "rmii";
 	dual_emac_res_vlan = <1>;
 };
@@ -87,6 +87,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio_pins>;
 	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
 };
 
 &mac {
-- 
1.9.1
