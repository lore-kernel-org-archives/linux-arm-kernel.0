From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 28 Jul 2014 09:24:03 -0700
Subject: [LINUX PATCH] ARM: zynq: DT: Remove DMA from board DTs
Message-ID: <1406564643-10417-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA engine is enabled for all DTs that derive from zynq-7000.dtsi.
There is no need to override the 'status' property in board DTs.

Cc: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
When the 'status' property was removed from the DMA node, this had been
overlooked.

	S?ren

 arch/arm/boot/dts/zynq-parallella.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 1595138ec499..41afd9da6876 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -34,10 +34,6 @@
 	};
 };
 
-&dmac_s {
-	status = "okay";
-};
-
 &gem0 {
 	status = "okay";
 	phy-mode = "rgmii-id";
-- 
2.0.1.1.gfbfc394
