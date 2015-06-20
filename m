From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Jun 2015 10:17:27 +0200
Subject: [PATCH v3 2/6] ARM: dts: pxa: add dma engine node to pxa3xx-nand
In-Reply-To: <1434788251-11839-1-git-send-email-robert.jarzmik@free.fr>
References: <1434788251-11839-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1434788251-11839-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the dma client description for pxa3xx-nand to use its dma through
device-tree.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 4eb1563..d90489b 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -30,6 +30,8 @@
 			reg = <0x43100000 90>;
 			interrupts = <45>;
 			clocks = <&clks CLK_NAND>;
+			dmas = <&pdma 97>;
+			dma-names = "data";
 			#address-cells = <1>;
 			#size-cells = <1>;	
 			status = "disabled";
-- 
2.1.4
