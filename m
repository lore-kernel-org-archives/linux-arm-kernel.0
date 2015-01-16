From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:35:17 +0900
Subject: [PATCH 05/17] ARM: shmobile: kzm9g-reference dts: Add r2025sd rtc node
In-Reply-To: <cover.1421371996.git.horms+renesas@verge.net.au>
References: <cover.1421371996.git.horms+renesas@verge.net.au>
Message-ID: <ae794653e064bf21527d5363f2358ed579ca9eff.1421371996.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a DT node for the R2025D real-time clock, which is connected to
i2c0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 3f19760..8a1675a 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -210,6 +210,11 @@
 			     <3 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rtc at 32 {
+		compatible = "ricoh,r2025sd";
+		reg = <0x32>;
+	};
+
 	as3711 at 40 {
 		compatible = "ams,as3711";
 		reg = <0x40>;
-- 
2.1.4
