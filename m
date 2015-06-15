From: romain.perier@gmail.com (Romain Perier)
Date: Mon, 15 Jun 2015 17:47:48 +0000
Subject: [PATCH] ARM: dts: rockchip: Add dmac_bus rx and tx for uart2
Message-ID: <1434390468-27296-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes warning "ttyS2 - Failed to request dma" from kernel logs

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 22316d0..816f40a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -385,6 +385,8 @@
 		clock-names = "baudclk", "apb_pclk";
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart2_xfer>;
+		dmas = <&dmac_bus_s 4>, <&dmac_bus_s 5>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
1.9.1
