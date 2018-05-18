From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:06 +0200
Subject: [PATCH 33/69] ARM: dts: koelsch: Enable watchdog support
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <9245dccc4a198997d2b0d2b51eef14763ccf2b30.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enable the watchdog, so the board can be restarted by a watchdog
timeout.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index f40321a1c917..fcdd0164142b 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -637,6 +637,11 @@
 	status = "okay";
 };
 
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
+};
+
 &sata0 {
 	status = "okay";
 };
-- 
2.11.0
