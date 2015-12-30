From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 30 Dec 2015 15:39:05 +0200
Subject: [PATCH 6/6] ARM: dts: am57xx: sbc-am57x: correct Eth PHY settings
In-Reply-To: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
References: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1451482745-1820-7-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Eth PHY settings to make it possible to run both phys at 1Gbps.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 9e0153a..8d93882 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -559,13 +559,13 @@
 
 &cpsw_emac0 {
 	phy_id = <&davinci_mdio>, <0>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-txid";
 	dual_emac_res_vlan = <0>;
 };
 
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-txid";
 	dual_emac_res_vlan = <1>;
 };
 
-- 
1.9.1
