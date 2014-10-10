From: julien.chauveau@neo-technologies.fr (Julien CHAUVEAU)
Date: Fri, 10 Oct 2014 10:04:13 +0200
Subject: [PATCH] ARM: dts: rockchip: enable DMA on SPI for rk3066 and rk3188
Message-ID: <1412928253-5119-1-git-send-email-julien.chauveau@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the RK3066 and RK3188 TRM, the two SPI controllers support DMA
handshake interface. Add the DMA properties so they can be used when needed.

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 499468d..9ba92de 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -367,6 +367,8 @@
 		reg = <0x20070000 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		dmas = <&dmac2 10>, <&dmac2 11>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -378,6 +380,8 @@
 		reg = <0x20074000 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		dmas = <&dmac2 12>, <&dmac2 13>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 };
-- 
1.9.1
