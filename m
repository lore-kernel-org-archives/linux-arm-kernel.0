From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:15 +0200
Subject: [PATCH 03/38] ARM: dts: r8a7743: add PFC support
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <328968b60231e522ea7e81ae0c83f59f13626a85.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7743 part of the PFC device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 0ddac81742e4..8d6b14075865 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for the r8a7743 SoC
  *
- * Copyright (C) 2016 Cogent Embedded Inc.
+ * Copyright (C) 2016-2017 Cogent Embedded Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
@@ -123,6 +123,11 @@
 			#power-domain-cells = <1>;
 		};
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a7743";
+			reg = <0 0xe6060000 0 0x250>;
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a7743",
 				     "renesas,rcar-dmac";
-- 
2.1.4
