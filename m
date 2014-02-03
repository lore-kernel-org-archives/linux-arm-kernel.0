From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Feb 2014 11:32:26 +0800
Subject: [PATCH v3 8/8] ARM: dts: sun7i: Add ethernet alias for GMAC
In-Reply-To: <1391398346-5094-1-git-send-email-wens@csie.org>
References: <1391398346-5094-1-git-send-email-wens@csie.org>
Message-ID: <1391398346-5094-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

U-Boot will insert MAC address into the device tree image.
It looks up ethernet[0-5] aliases to find the ethernet nodes.
Alias GMAC as ethernet0, as it is the only ethernet controller used.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 65fb8d0..c48fb11 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -17,7 +17,7 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
-		ethernet0 = &emac;
+		ethernet0 = &gmac;
 	};
 
 	cpus {
-- 
1.9.rc1
