From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 16 Nov 2014 18:37:25 +0100
Subject: [PATCHv2 4/8] arm: mvebu: use recently introduced uart label for
 stdout-path
In-Reply-To: <cover.1416158990.git.arno@natisbad.org>
References: <cover.1416158990.git.arno@natisbad.org>
Message-ID: <8b2c3e42793a9276e7b8ded0623675b95a5f68c2.1416158990.git.arno@natisbad.org>
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
index 469cf7137595..cccf54784c4c 100644
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
