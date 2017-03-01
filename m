From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  2 Mar 2017 00:56:20 +0100
Subject: [PATCH 3/4] ARM: dts: rockchip: add rk3066/rk3188 dw-mmc resets
In-Reply-To: <20170301235621.31726-1-heiko@sntech.de>
References: <20170301235621.31726-1-heiko@sntech.de>
Message-ID: <20170301235621.31726-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dw-mmc got its reset-properties specified, so add the softresets
for it in rk3066/rk3188.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 0b45811cf28b..233513cdd279 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -224,6 +224,8 @@
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <256>;
+		resets = <&cru SRST_SDMMC>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
@@ -234,6 +236,8 @@
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <256>;
+		resets = <&cru SRST_SDIO>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
@@ -244,6 +248,8 @@
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <256>;
+		resets = <&cru SRST_EMMC>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
-- 
2.11.0
