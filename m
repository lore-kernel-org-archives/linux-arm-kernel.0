From: eballetbo@iseebcn.com (Enric Balletbo i Serra)
Date: Wed, 25 Jun 2014 13:42:05 +0200
Subject: [PATCH] ARM: dts: Fix TI CPSW Phy mode selection on IGEP COM AQUILA.
Message-ID: <1403696525-10099-1-git-send-email-eballetbo@iseebcn.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As this board use external clock for RMII interface we should specify 'rmii'
phy mode and 'rmii-clock-ext' to make ethernet working.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/am335x-igep0033.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 8a0a72d..a1a0cc5 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -105,10 +105,16 @@
 
 &cpsw_emac0 {
 	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "rmii";
 };
 
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "rmii";
+};
+
+&phy_sel {
+	rmii-clock-ext;
 };
 
 &elm {
-- 
1.9.1
