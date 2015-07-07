From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  7 Jul 2015 16:10:14 +0200
Subject: [PATCH/RFC 08/11] ARM: shmobile: r8a7793: Link CPG to RST using
 "renesas, modemr"
In-Reply-To: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
References: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1436278217-20522-9-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a link from the Clock Pulse Generator node to the Reset Controller
node, so the CPG can read the Mode Monitoring Register (MODEMR) to
obtain the MD pin values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index fbb1aa3740e2b55e..4bddaf2fbd0b2e1c 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -192,6 +192,7 @@
 					     "lb", "qspi", "sdh", "sd0", "z",
 					     "rcan", "adsp";
 			#power-domain-cells = <0>;
+			renesas,modemr = <&rst 0x60>;
 		};
 
 		/* Variable factor clocks */
-- 
1.9.1
