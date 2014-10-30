From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 14:57:09 +0900
Subject: [PATCH/RFC] ARM: shmobile: r8a7790: Add MMCIF clock rate to device
 tree
Message-ID: <1414648629-30736-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
---
Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

If this is useful I wonder if it is should be set in the lager board DTS
file instead of the r8a7790 SoC DTSI file.

 arch/arm/boot/dts/r8a7790.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 69b7cd0..b8cd8e3 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -400,6 +400,7 @@
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
 		reg-io-width = <4>;
+		renesas,clk-rate = <97500000>;
 		status = "disabled";
 	};
 
@@ -411,6 +412,7 @@
 		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>;
 		dma-names = "tx", "rx";
 		reg-io-width = <4>;
+		renesas,clk-rate = <97500000>;
 		status = "disabled";
 	};
 
-- 
2.1.1
