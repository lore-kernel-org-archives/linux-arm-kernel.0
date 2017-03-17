From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Mar 2017 09:39:50 +0100
Subject: [PATCH 1/2] arm64: dts: rockchip: add rk3368 dw-mmc resets
Message-ID: <20170317083951.14343-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dw-mmc got its reset-properties specified, so add the softresets
for it on the rk3368.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index a635adc47e74..06fa6e00904d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -237,6 +237,8 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		resets = <&cru SRST_MMC0>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
@@ -249,6 +251,8 @@
 		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+		resets = <&cru SRST_SDIO0>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
@@ -261,6 +265,8 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		resets = <&cru SRST_EMMC>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
-- 
2.11.0
