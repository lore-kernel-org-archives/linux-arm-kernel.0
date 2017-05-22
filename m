From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:58:35 +0200
Subject: [PATCH 02/35] arm64: dts: m3ulcb: Update memory node to 2 GiB map
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <2a3ee629ed8b2f1de496f57edd3f30cd5e8584cf.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>

This patch updates memory region:

  - After changes, the new map of the m3ulcb board on R8A7796 SoC
    Bank0: 1GiB RAM : 0x000048000000 -> 0x0007fffffff
    Bank1: 1GiB RAM : 0x000600000000 -> 0x0063fffffff

  - Before changes, the old map looked like this:
    Bank0: 1GiB RAM : 0x000048000000 -> 0x0007fffffff

Signed-off-by: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>
Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index 5554b555b874..02051a3236a5 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -32,6 +32,11 @@
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
+	memory at 600000000 {
+		device_type = "memory";
+		reg = <0x6 0x00000000 0x0 0x40000000>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
-- 
2.1.4
