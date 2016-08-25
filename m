From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 25 Aug 2016 11:00:41 +0800
Subject: [PATCH v2 2/2] arm64: dts: hi6220: add resets property into dwmmc
 nodes
In-Reply-To: <1472094041-5357-1-git-send-email-guodong.xu@linaro.org>
References: <1472094041-5357-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1472094041-5357-2-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add resets property into dwmmc_0, dwmmc_1 and dwmmc_2 for hi6220

Code and documentation to this property were confirmed by maintainers.
See:
[1] https://patchwork.kernel.org/patch/9276607/
[2] https://patchwork.kernel.org/patch/8487151/
[3] https://lkml.org/lkml/2016/8/12/91

cc: Jaehoon Chung <jh80.chung@samsung.com>
cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index d0b887a..63608e9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -771,6 +771,7 @@
 			interrupts = <0x0 0x48 0x4>;
 			clocks = <&sys_ctrl 2>, <&sys_ctrl 1>;
 			clock-names = "ciu", "biu";
+			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC0>;
 			bus-width = <0x8>;
 			vmmc-supply = <&ldo19>;
 			pinctrl-names = "default";
@@ -790,6 +791,7 @@
 			#size-cells = <0x0>;
 			clocks = <&sys_ctrl 4>, <&sys_ctrl 3>;
 			clock-names = "ciu", "biu";
+			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC1>;
 			vqmmc-supply = <&ldo7>;
 			vmmc-supply = <&ldo10>;
 			bus-width = <0x4>;
@@ -807,6 +809,7 @@
 			interrupts = <0x0 0x4a 0x4>;
 			clocks = <&sys_ctrl HI6220_MMC2_CIUCLK>, <&sys_ctrl HI6220_MMC2_CLK>;
 			clock-names = "ciu", "biu";
+			resets = <&sys_ctrl PERIPH_RSTDIS0_MMC2>;
 			bus-width = <0x4>;
 			broken-cd;
 			pinctrl-names = "default", "idle";
-- 
1.9.1
