From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 19 Nov 2014 00:01:59 +0100
Subject: [PATCHv4 03/10] arm: mvebu: use recently introduced uart label for
 stdout-path
In-Reply-To: <cover.1416351425.git.arno@natisbad.org>
References: <cover.1416351425.git.arno@natisbad.org>
Message-ID: <206fa4769a1e02f3e6b139160cd5dd9d25c90837.1416351426.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that labels for uartX are available in Marvell Armada .dtsi files,
this patch replaces the "/soc/internal-regs/serial at 12000" found in
armada-xp-lenovo-ix4-300d.dts file for stdout-path property by the more
concise &uart0.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index aa5463c91924..088d8d2fe9eb 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -22,7 +22,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
-		stdout-path = "/soc/internal-regs/serial at 12000";
+		stdout-path = &uart0;
 	};
 
 	memory {
-- 
2.1.1
