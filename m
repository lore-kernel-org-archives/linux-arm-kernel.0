From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sat, 30 Aug 2014 12:15:38 +0800
Subject: [PATCH v3 2/6] ARM: dts: hix5hd2: add mmc node
In-Reply-To: <1409372142-5960-1-git-send-email-zhangfei.gao@linaro.org>
References: <1409372142-5960-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1409372142-5960-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 012525c..802331b 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -167,6 +167,23 @@
 			};
 		};
 
+		/* unremovable emmc as mmcblk0 */
+		mmc: mmc at 1830000 {
+			compatible = "snps,dw-mshc";
+			reg = <0x1830000 0x1000>;
+			interrupts = <0 35 4>;
+			clocks = <&clock HIX5HD2_MMC_CIU_RST>, <&clock HIX5HD2_MMC_BIU_CLK>;
+			clock-names = "ciu", "biu";
+		};
+
+		sd: mmc at 1820000 {
+			compatible = "snps,dw-mshc";
+			reg = <0x1820000 0x1000>;
+			interrupts = <0 34 4>;
+			clocks = <&clock HIX5HD2_SD_CIU_RST>, <&clock HIX5HD2_SD_BIU_CLK>;
+			clock-names = "ciu","biu";
+		};
+
 		gmac0: ethernet at 1840000 {
 			compatible = "hisilicon,hix5hd2-gmac";
 			reg = <0x1840000 0x1000>,<0x184300c 0x4>;
-- 
1.7.9.5
