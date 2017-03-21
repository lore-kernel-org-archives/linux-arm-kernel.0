From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 21 Mar 2017 18:13:47 +0300
Subject: [PATCH] ARM: dts: rockchip: setup DMA-channels for mmc0 and emmc for
 rk3188
Message-ID: <1490109227-4006-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enable DMA-based transfers for SD/eMMC card adapters
and reduce number of interrupts produced by SD-card/eMMC-card
adapters.

Sometimes interrupts from SD-card/eMMC-card adapters running in
PIO mode blocks execution of hrtimers and I2S DMA callbacks for
a long periods (100 ms or more).

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 arch/arm/boot/dts/rk3188.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 44da3d42..de786f8 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -638,3 +638,13 @@
 &wdt {
 	compatible = "rockchip,rk3188-wdt", "snps,dw-wdt";
 };
+
+&mmc0 {
+	dmas = <&dmac2 1>;
+	dma-names = "rx-tx";
+};
+
+&emmc {
+	dmas = <&dmac2 4>;
+	dma-names = "rx-tx";
+};
-- 
1.7.9.5
