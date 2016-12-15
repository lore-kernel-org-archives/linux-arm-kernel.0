From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 15 Dec 2016 16:31:29 +0100
Subject: [PATCH resend] arm64: dts: r8a7796: salvator-x: Update memory node to
 4 GiB map
Message-ID: <1481815889-15583-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch updates memory region:

  - After changes, the new map of the Salvator-X board on R8A7796 SoC
    Bank0: 2GiB RAM : 0x000048000000 -> 0x000bfffffff
    Bank1: 2GiB RAM : 0x000600000000 -> 0x0067fffffff

  - Before changes, the old map looked like this:
    Bank0: 2GiB RAM : 0x000048000000 -> 0x000bfffffff

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Correct size of old map]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Simon, please apply!

U-Boot already adds the second memory region to the "reg" property of
the first memory node in DT, so this patch is actually a no-op.
IMHO it doesn't make much sense to keep on pretending we don't have
enabled memory outside the 32-bit address space.
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index f35e96ca7d6050b7..38bde9de3250ecbb 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -31,6 +31,11 @@
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
 
+	memory at 600000000 {
+		device_type = "memory";
+		reg = <0x6 0x00000000 0x0 0x80000000>;
+	};
+
 	reg_1p8v: regulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
-- 
1.9.1
