From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  6 Apr 2017 15:31:27 +0200
Subject: [PATCH] arm64: dts: r8a7795-salvator-x: Update memory node to 4 GiB
 map
Message-ID: <1491485487-2006-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch addes memory region:

  - After changes, the Salvator-X board has the following map:
    Bank0: 1GiB RAM : 0x000048000000 -> 0x0007fffffff
    Bank1: 1GiB RAM : 0x000500000000 -> 0x0053fffffff
    Bank2: 1GiB RAM : 0x000600000000 -> 0x0063fffffff
    Bank3: 1GiB RAM : 0x000700000000 -> 0x0073fffffff

  - Before changes, the old map looked like this:
    Bank0: 1GiB RAM : 0x000048000000 -> 0x0007fffffff

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This patch is looooong overdue.

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 639aa085d9966676..f1b6ad3def15b2f5 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -56,6 +56,21 @@
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
+	memory at 500000000 {
+		device_type = "memory";
+		reg = <0x5 0x00000000 0x0 0x40000000>;
+	};
+
+	memory at 600000000 {
+		device_type = "memory";
+		reg = <0x6 0x00000000 0x0 0x40000000>;
+	};
+
+	memory at 700000000 {
+		device_type = "memory";
+		reg = <0x7 0x00000000 0x0 0x40000000>;
+	};
+
 	x12_clk: x12 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.7.4
