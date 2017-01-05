From: t.remmet@phytec.de (Teresa Remmet)
Date: Thu, 5 Jan 2017 15:50:51 +0100
Subject: [PATCH 6/6] ARM: dts: am335x-wega: Update ethernet phy node
In-Reply-To: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
Message-ID: <1483627851-17996-7-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update ethernet phy1 node to use phy-handle now.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-wega.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index e97fd6d..8ce5417 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -119,11 +119,17 @@
 };
 
 &cpsw_emac1 {
-	phy_id = <&davinci_mdio>, <1>;
+	phy-handle = <&phy1>;
 	phy-mode = "mii";
 	dual_emac_res_vlan = <2>;
 };
 
+&davinci_mdio {
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
 &mac {
 	slaves = <2>;
 	pinctrl-names = "default";
-- 
1.9.1
