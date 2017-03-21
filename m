From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue, 21 Mar 2017 15:08:18 +0800
Subject: [PATCH] arm64: dts: hi6220: enable DMA in spi0
Message-ID: <20170321070818.3247-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>

Enable DMA in spi0.

Cc: Antonio Borneo <borneo.antonio@gmail.com>
Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 470461d..e40625f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -682,7 +682,8 @@
 			reg = <0x0 0xf7106000 0x0 0x1000>;
 			interrupts = <0 50 4>;
 			bus-id = <0>;
-			enable-dma = <0>;
+			dmas =  <&dma0 0 &dma0 1>;
+			dma-names = "rx", "tx";
 			clocks = <&sys_ctrl HI6220_SPI_CLK>;
 			clock-names = "apb_pclk";
 			pinctrl-names = "default";
-- 
2.10.2
