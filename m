From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 21 Nov 2014 20:45:28 +0100
Subject: [PATCHv5 03/10] arm: mvebu: use recently introduced uart label for
 stdout-path
In-Reply-To: <cover.1416598536.git.arno@natisbad.org>
References: <cover.1416598536.git.arno@natisbad.org>
Message-ID: <401905040d8e32f3070c75ccca0102fad1cf323c.1416598536.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that labels for uartX are available in Marvell Armada .dtsi files,
this patch replaces the "/soc/internal-regs/serial at 12000" found in
armada-xp-lenovo-ix4-300d.dts file for stdout-path property by the more
concise &uart0.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
