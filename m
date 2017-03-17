From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Mar 2017 09:39:51 +0100
Subject: [PATCH 2/2] arm64: dts: rockchip: add rk3399 dw-mmc resets
In-Reply-To: <20170317083951.14343-1-heiko@sntech.de>
References: <20170317083951.14343-1-heiko@sntech.de>
Message-ID: <20170317083951.14343-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dw-mmc got its reset-properties specified, so add the softresets
for it on the rk3399.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 8e6d1bdeb9c3..c228898eda81 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -241,6 +241,8 @@
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
+		resets = <&cru SRST_SDIO0>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
@@ -255,6 +257,8 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		power-domains = <&power RK3399_PD_SD>;
+		resets = <&cru SRST_SDMMC>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
-- 
2.11.0
