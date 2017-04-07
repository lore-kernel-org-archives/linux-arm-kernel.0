From: xuwei5@hisilicon.com (Wei.Xu)
Date: Fri, 7 Apr 2017 10:07:54 +0800
Subject: [PATCH 3/5] arm64: dts: hisi: add RoCE nodes for the hip07 SoC
In-Reply-To: <1491530876-109791-1-git-send-email-xuwei5@hisilicon.com>
References: <1491530876-109791-1-git-send-email-xuwei5@hisilicon.com>
Message-ID: <1491530876-109791-4-git-send-email-xuwei5@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Xu <xuwei5@hisilicon.com>

Add the infiniband node to support the RoCE function
on the hip07 SoC.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 81 ++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 2feb362..bc54b61 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1324,5 +1324,86 @@
 			status = "disabled";
 			dma-coherent;
 		};
+
+		infiniband at c4000000 {
+			compatible = "hisilicon,hns-roce-v1";
+			reg = <0x0 0xc4000000 0x0 0x100000>;
+			dma-coherent;
+			eth-handle = <&eth2 &eth3 0 0 &eth0 &eth1>;
+			dsaf-handle = <&dsaf0>;
+			node-guid = [00 9A CD 00 00 01 02 03];
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&mbigen_dsa_roce>;
+			interrupts = <722 1>,
+				     <723 1>,
+				     <724 1>,
+				     <725 1>,
+				     <726 1>,
+				     <727 1>,
+				     <728 1>,
+				     <729 1>,
+				     <730 1>,
+				     <731 1>,
+				     <732 1>,
+				     <733 1>,
+				     <734 1>,
+				     <735 1>,
+				     <736 1>,
+				     <737 1>,
+				     <738 1>,
+				     <739 1>,
+				     <740 1>,
+				     <741 1>,
+				     <742 1>,
+				     <743 1>,
+				     <744 1>,
+				     <745 1>,
+				     <746 1>,
+				     <747 1>,
+				     <748 1>,
+				     <749 1>,
+				     <750 1>,
+				     <751 1>,
+				     <752 1>,
+				     <753 1>,
+				     <785 1>,
+				     <754 4>;
+
+			interrupt-names = "hns-roce-comp-0",
+					  "hns-roce-comp-1",
+					  "hns-roce-comp-2",
+					  "hns-roce-comp-3",
+					  "hns-roce-comp-4",
+					  "hns-roce-comp-5",
+					  "hns-roce-comp-6",
+					  "hns-roce-comp-7",
+					  "hns-roce-comp-8",
+					  "hns-roce-comp-9",
+					  "hns-roce-comp-10",
+					  "hns-roce-comp-11",
+					  "hns-roce-comp-12",
+					  "hns-roce-comp-13",
+					  "hns-roce-comp-14",
+					  "hns-roce-comp-15",
+					  "hns-roce-comp-16",
+					  "hns-roce-comp-17",
+					  "hns-roce-comp-18",
+					  "hns-roce-comp-19",
+					  "hns-roce-comp-20",
+					  "hns-roce-comp-21",
+					  "hns-roce-comp-22",
+					  "hns-roce-comp-23",
+					  "hns-roce-comp-24",
+					  "hns-roce-comp-25",
+					  "hns-roce-comp-26",
+					  "hns-roce-comp-27",
+					  "hns-roce-comp-28",
+					  "hns-roce-comp-29",
+					  "hns-roce-comp-30",
+					  "hns-roce-comp-31",
+					  "hns-roce-async",
+					  "hns-roce-common";
+		};
 	};
 };
-- 
1.9.1
