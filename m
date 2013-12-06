From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  7 Dec 2013 01:29:43 +0800
Subject: [PATCH 10/10] ARM: dts: sun7i: Add ethernet alias for GMAC
In-Reply-To: <1386350983-13281-1-git-send-email-wens@csie.org>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
Message-ID: <1386350983-13281-11-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

U-Boot will insert MAC address into the device tree image.
It looks up ethernet[0-5] aliases to find the ethernet nodes.
Alias GMAC as ethernet0, as it is the only ethernet controller used.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 64b1391..f7c57c6 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -16,6 +16,10 @@
 / {
 	interrupt-parent = <&gic>;
 
+	aliases {
+		ethernet0 = &gmac;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.5.1
