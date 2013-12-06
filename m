From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  7 Dec 2013 01:29:40 +0800
Subject: [PATCH 07/10] ARM: dts: sun7i: cubietruck: Enable the GMAC
In-Reply-To: <1386350983-13281-1-git-send-email-wens@csie.org>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
Message-ID: <1386350983-13281-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CubieTruck uses the GMAC with an RGMII phy.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 8a1009d..af212a2 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -33,6 +33,14 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		gmac: ethernet at 01c50000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gmac_pins_rgmii>;
+			snps,phy-addr = <1>;
+			phy-mode = "rgmii";
+			status = "okay";
+		};
 	};
 
 	leds {
-- 
1.8.5.1
