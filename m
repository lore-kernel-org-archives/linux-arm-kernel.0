From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 25 Nov 2014 17:40:04 +0100
Subject: [PATCH v2 3/3] ARM: at91: sama5d4: Add SFR
In-Reply-To: <1416933604-31446-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1416933604-31446-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1416933604-31446-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sama4d4 has Special Function Registers that allow to manage DDR, OHCI, EBI
and AIC interrupt redirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index e0157b0f075c..9e281e22d591 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -826,6 +826,11 @@
 				status = "disabled";
 			};
 
+			sfr: sfr at f8028000 {
+				compatible = "atmel,sama5d4-sfr", "syscon";
+				reg = <0xf8028000 0x4000>;
+			};
+
 			mmc1: mmc at fc000000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfc000000 0x600>;
-- 
2.1.0
