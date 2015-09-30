From: w.f@huawei.com (Fei Wang)
Date: Wed, 30 Sep 2015 19:05:11 +0800
Subject: [PATCH 8/8] arm64: dts: Add Hi6220 mtcmos regulator node
In-Reply-To: <1443611111-3196-1-git-send-email-w.f@huawei.com>
References: <1443611111-3196-1-git-send-email-w.f@huawei.com>
Message-ID: <1443611111-3196-9-git-send-email-w.f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add mtcmos regulator dts file for Hi6220 SoC.

Signed-off-by: Fei Wang <w.f@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 40f895b..9b1a6ed 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -167,6 +167,27 @@
 			clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		mtcmos {
+			compatible = "hisilicon,hi6220-mtcmos-driver";
+			hisilicon,mtcmos-steady-us = <10>;
+			hisilicon,mtcmos-sc-on-base  = <0xf7800000>;
+			hisilicon,mtcmos-acpu-on-base = <0xf65a0000>;
+
+			mtcmos1: regulator at a1{
+				regulator-name = "G3D_PD_VDD";
+				regulator-compatible = "mtcmos1";
+				hisilicon,ctrl-regs = <0x830 0x834 0x83c>;
+				hisilicon,ctrl-data = <1 0x1>;
+			};
+
+			mtcmos2: regulator at a2{
+				regulator-name = "SOC_MED";
+				regulator-compatible = "mtcmos2";
+				hisilicon,ctrl-regs = <0x830 0x834 0x83c>;
+				hisilicon,ctrl-data = <2 0x1>;
+			};
+		};
 	};
 
 	pmic: pmic at F8000000 {
-- 
1.7.9.5
