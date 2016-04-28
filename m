From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Thu, 28 Apr 2016 15:09:04 +0800
Subject: [PATCH net-next 4/4] dts: hisi: update hns dst for changing property
 port-id to reg
In-Reply-To: <1461827344-52230-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1461827344-52230-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1461827344-52230-5-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Indexes should generally be avoided. This patch changes property port-id
to reg in dsaf port node.

Signed-off-by: Yisen Zhuang <yisen.zhuang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
index 7d62514..b6a130c 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
@@ -24,6 +24,8 @@ soc0: soc at 000000000 {
 	};
 
 	dsaf0: dsa at c7000000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "hisilicon,hns-dsaf-v1";
 		mode = "6port-16rss";
 		interrupt-parent = <&mbigen_dsa>;
@@ -124,20 +126,20 @@ soc0: soc at 000000000 {
 		dma-coherent;
 
 		port at 0 {
-			port-id = <0>;
+			reg = <0>;
 			serdes-syscon = <&serdes_ctrl0>;
 		};
 		port at 1 {
-			port-id = <1>;
+			reg = <1>;
 			serdes-syscon = <&serdes_ctrl0>;
 		};
 		port at 4 {
-			port-id = <4>;
+			reg = <4>;
 			phy-handle = <&soc0_phy0>;
 			serdes-syscon = <&serdes_ctrl1>;
 		};
 		port at 5 {
-			port-id = <5>;
+			reg = <5>;
 			phy-handle = <&soc0_phy1>;
 			serdes-syscon = <&serdes_ctrl1>;
 		};
-- 
1.9.1
