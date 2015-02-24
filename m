From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 24 Feb 2015 14:16:50 +0900
Subject: [PATCH v4 7/8] arm64: dts: exynos: Add ADMA dt node for Exynos5433 SoC
In-Reply-To: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1424755011-15999-8-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Inha Song <ideal.song@samsung.com>

This patch adds ADMA (Advanced DMA) device tree node for Exynos5433 SoC.
In Exynos5433 SoC, ADMA is used for I2S audio interface.

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Inha Song <ideal.song@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 1c68d9e..6becaca 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -462,6 +462,17 @@
 				#dma-channels = <8>;
 				#dma-requests = <32>;
 			};
+
+			adma: adma at 11420000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0x11420000 0x1000>;
+				interrupts = <0 73 0>;
+				clocks = <&cmu_aud CLK_ACLK_DMAC>;
+				clock-names = "apb_pclk";
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
 		};
 
 		serial_0: serial at 14c10000 {
-- 
1.8.5.5
