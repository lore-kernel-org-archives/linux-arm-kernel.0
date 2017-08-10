From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 10 Aug 2017 10:26:15 +0800
Subject: [PATCH v2 9/9] arm64: dts: hi3660: add bindings for DMA
In-Reply-To: <20170810022615.19204-1-guodong.xu@linaro.org>
References: <20170810022615.19204-1-guodong.xu@linaro.org>
Message-ID: <20170810022615.19204-10-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Ruyi <wangruyi@huawei.com>

Add bindings for DMA.

Signed-off-by: Wang Ruyi <wangruyi@huawei.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 41841f7..545d435 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -436,6 +436,19 @@
 			status = "disabled";
 		};
 
+		dma0: dma at fdf30000 {
+			compatible = "hisilicon,k3-dma-1.0";
+			reg = <0x0 0xfdf30000 0x0 0x1000>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			dma-requests = <32>;
+			dma-min-chan = <1>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_DMAC>;
+			dma-no-cci;
+			dma-type = "hi3660_dma";
+		};
+
 		rtc0: rtc at fff04000 {
 			compatible = "arm,pl031", "arm,primecell";
 			reg = <0x0 0Xfff04000 0x0 0x1000>;
-- 
2.10.2
