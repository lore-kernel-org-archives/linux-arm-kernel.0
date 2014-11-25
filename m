From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 25 Nov 2014 17:40:03 +0100
Subject: [PATCH v2 2/3] ARM: at91: sama5d3: Add SFR
In-Reply-To: <1416933604-31446-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1416933604-31446-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1416933604-31446-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sama5d3 has Special Function Registers that allow to manage OHCI, EBI and
the UTMI clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 5f4144d1e3a1..499b59f48055 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -217,6 +217,11 @@
 				status = "disabled";
 			};
 
+			sfr: sfr at f0038000 {
+				compatible = "atmel,sama5d3-sfr", "syscon";
+				reg = <0xf0038000 0x4000>;
+			};
+
 			mmc1: mmc at f8000000 {
 				compatible = "atmel,hsmci";
 				reg = <0xf8000000 0x600>;
-- 
2.1.0
