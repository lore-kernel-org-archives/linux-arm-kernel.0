From: david@lechnology.com (David Lechner)
Date: Tue, 25 Oct 2016 18:32:48 -0500
Subject: [PATCH] ARM: DTS: da850: Add DMA to SPI0
Message-ID: <1477438368-16208-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the bindings for DMA on SPI0

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 06a5abc..baadebe 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -349,6 +349,8 @@
 			num-cs = <6>;
 			ti,davinci-spi-intr-line = <1>;
 			interrupts = <20>;
+			dmas = <&edma0 14 0>, <&edma0 15 0>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 		spi1: spi at 30e000 {
-- 
2.7.4
