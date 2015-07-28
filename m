From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:04:03 +0000
Subject: [PATCH 09/10] ARM: dts: atlas7: put pinctl property to get pinmux for
 NAND
In-Reply-To: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
References: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438074244-18708-10-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huayi Li <huayi.li@csr.com>

Nand controller often share some pins with sd/mmc controller on
atlas and prima series, nand node can be disabled if the pins are
used by sd/mmc controller.

Signed-off-by: Huayi Li <huayi.li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index de38bc98..83449b3 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1458,6 +1458,8 @@
 			nand at 17050000 {
 				compatible = "sirf,atlas7-nand";
 				reg = <0x17050000 0x10000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&nd_df_pmx>;
 				interrupts = <0 41 0>;
 				clocks = <&car 108>, <&car 112>;
 				clock-names = "nand_io", "nand_nand";
-- 
1.9.1
