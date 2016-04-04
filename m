From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:20 +0900
Subject: [PATCH 12/26] ARM: dts: kzm9d: use generic pinctrl properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <20ccdd90ab22808e582d81cdfac09e3b804e7b20.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the kzm9d device tree to use the generic properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 8c24975e8f9d..a35b851e1cd7 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -105,8 +105,8 @@
 
 &pfc {
 	uart1_pins: serial at e1030000 {
-		renesas,groups = "uart1_ctrl", "uart1_data";
-		renesas,function = "uart1";
+		groups = "uart1_ctrl", "uart1_data";
+		function = "uart1";
 	};
 };
 
-- 
2.1.4
