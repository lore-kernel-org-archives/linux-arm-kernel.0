From: yankejian@huawei.com (yankejian)
Date: Sat, 10 Oct 2015 16:00:49 +0800
Subject: [PATCH net-next] net: updates HNS config and documents
Message-ID: <1444464049-63248-1-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 updates the bindings documents and dtsi file according to the review
comments from Rob Herring <robh@kernel.org>

Signed-off-by: huangdaode <huangdaode@hisilicon.com>
Signed-off-by: yankejian <yankejian@huawei.com>
---
 Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt | 2 +-
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi                 | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
index 9940aa0..9c23fdf 100644
--- a/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
+++ b/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
@@ -12,7 +12,7 @@ Example:
          mdio at 803c0000 {
                    #address-cells = <1>;
                    #size-cells = <0>;
-                   compatible = "hisilicon,mdio","hisilicon,hns-mdio";
+                   compatible = "hisilicon,hns-mdio","hisilicon,mdio";
                    reg = <0x0 0x803c0000 0x0 0x10000>;
 
                    ethernet-phy at 0 {
diff --git a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
index 3500586..606dd5a 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
@@ -13,14 +13,12 @@ soc0: soc at 000000000 {
 		reg = <0x0 0x803c0000 0x0 0x10000
 		       0x0 0x80000000 0x0 0x10000>;
 
-		soc0_phy4: ethernet-phy at 4 {
+		soc0_phy0: ethernet-phy at 0 {
 			reg = <0x0>;
-			device_type = "ethernet-phy";
 			compatible = "ethernet-phy-ieee802.3-c22";
 		};
-		soc0_phy5: ethernet-phy at 5 {
+		soc0_phy1: ethernet-phy at 1 {
 			reg = <0x1>;
-			device_type = "ethernet-phy";
 			compatible = "ethernet-phy-ieee802.3-c22";
 		};
 	};
@@ -37,7 +35,7 @@ soc0: soc at 000000000 {
 		       0x0 0xc7000000 0x0 0x60000
 		       >;
 
-		phy-handle = <0 0 0 0 &soc0_phy4 &soc0_phy5 0 0>;
+		phy-handle = <0 0 0 0 &soc0_phy0 &soc0_phy1 0 0>;
 		interrupts = <
 			/* [14] ge fifo err 8 / xge 6**/
 			149 0x4 150 0x4 151 0x4 152 0x4
-- 
1.9.1
