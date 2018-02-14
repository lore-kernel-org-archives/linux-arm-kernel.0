From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 14 Feb 2018 17:55:03 +0200
Subject: [PATCH] ARM: ds: keystone-k2g: add watchdog support
Message-ID: <1518623703-24529-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a watchdog node for keystone-k2g, with the corresponding clock and
power domain handles.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index fd06171..ca94221 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -583,5 +583,12 @@
 			power-domains = <&k2g_pds 0x0013>;
 			clocks = <&k2g_clks 0x0013 0>;
 		};
+
+		wdt: wdt at 02250000 {
+			compatible = "ti,keystone-wdt", "ti,davinci-wdt";
+			reg = <0x02250000 0x80>;
+			power-domains = <&k2g_pds 0x22>;
+			clocks = <&k2g_clks 0x22 0>;
+		};
 	};
 };
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
