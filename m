From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:17:54 +0100
Subject: [PATCH 12/16] arm64: dts: r8a7796: salvator-x: Update memory node to
 4 GiB map
In-Reply-To: <cover.1483700694.git.horms+renesas@verge.net.au>
References: <cover.1483700694.git.horms+renesas@verge.net.au>
Message-ID: <d78fcc47e6814605eb90cd4ab1d79f9609ff32a4.1483700694.git.horms+renesas@verge.net.au>
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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index f35e96ca7d60..38bde9de3250 100644
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
2.7.0.rc3.207.g0ac5344
