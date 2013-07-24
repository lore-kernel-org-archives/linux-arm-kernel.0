From: rizhao@nvidia.com (Richard Zhao)
Date: Wed, 24 Jul 2013 12:09:58 +0800
Subject: [PATCH 5/9] spi: tegra20-sflash: move to generic dma DT binding
In-Reply-To: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
Message-ID: <1374639002-16753-6-git-send-email-rizhao@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

update binding doc.

Signed-off-by: Richard Zhao <rizhao@nvidia.com>
---
 .../devicetree/bindings/spi/nvidia,tegra20-sflash.txt          | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
index 7b53da5..fa22d1b 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
@@ -4,8 +4,11 @@ Required properties:
 - compatible : should be "nvidia,tegra20-sflash".
 - reg: Should contain SFLASH registers location and length.
 - interrupts: Should contain SFLASH interrupts.
-- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
-  request selector for this SFLASH controller.
+
+Optional properties:
+- dmas : The Tegra DMA controller's phandle and request selector for
+  this SFLASH controller.
+- dma-names : Should be "rx-tx".
 
 Recommended properties:
 - spi-max-frequency: Definition as per
@@ -17,7 +20,8 @@ spi at 7000c380 {
 	compatible = "nvidia,tegra20-sflash";
 	reg = <0x7000c380 0x80>;
 	interrupts = <0 39 0x04>;
-	nvidia,dma-request-selector = <&apbdma 16>;
+	dmas = <&apbdma 16>;
+	dma-names = "rx-tx";
 	spi-max-frequency = <25000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
1.8.1.5
