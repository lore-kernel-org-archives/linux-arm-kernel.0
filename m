From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 12 Mar 2018 09:10:06 +0200
Subject: [REPOST PATCH 1/2] ARM: dts: keystone-k2g: add watchdog support
In-Reply-To: <1520838607-11709-1-git-send-email-t-kristo@ti.com>
References: <1520838607-11709-1-git-send-email-t-kristo@ti.com>
Message-ID: <1520838607-11709-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a watchdog node for keystone-k2g, with the corresponding clock and
power domain handles.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index fd06171..2656701 100644
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
