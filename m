From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:28 +0200
Subject: [PATCH 08/41] ARM: dts: lager: Name vin pfc subnode after device name
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <da84fd93486b4cd2a32c6a2effc5368bcb2269bc.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Name the Pin Function Controller subnode for VIN1 after its device name,
instead of using the generic and indexless "vin".

This avoids conflicts when enabling support for more video inputs later,
either here or in a DT overlay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 09b633f5ad07..52b56fcaddf2 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -427,7 +427,7 @@
 		function = "usb2";
 	};
 
-	vin1_pins: vin {
+	vin1_pins: vin1 {
 		groups = "vin1_data8", "vin1_clk";
 		function = "vin1";
 	};
-- 
2.7.0.rc3.207.g0ac5344
