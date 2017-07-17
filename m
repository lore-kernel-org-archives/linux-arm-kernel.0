From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 17 Jul 2017 10:47:18 -0700
Subject: [PATCH] ARM: dts: da850-lcdk: drop unused VPIF endpoints
Message-ID: <20170717174718.28343-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the unused endpoints.  They should only be used when there is an
actual remote-endpoint connected.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index b837fec70eec..a0f0916156e6 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -318,11 +318,4 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&vpif_capture_pins>;
 	status = "okay";
-
-	/* VPIF capture port */
-	port {
-		vpif_ch0: endpoint {
-			  bus-width = <8>;
-		};
-	};
 };
-- 
2.9.3
