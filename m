From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 28 Jan 2015 19:39:00 +0100
Subject: [PATCH 2/5] ARM: at91/dt: add SMC0/1 nodes in at91sam9263 dtsi
In-Reply-To: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1422470343-25981-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Stein <alexanders83@web.de>

Add the SMC0/1 (Static Memory Controller) nodes in at91sam9263sama5d3 dtsi.

Signed-off-by: Alexander Stein <alexanders83@web.de>
[boris.brezillon at free-electrons.com: shrink SMC reg ranges]
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index ceb0254..79f9b81 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -361,11 +361,21 @@
 				reg = <0xffffe200 0x200>;
 			};
 
+			smc0: smc0 at ffffe400 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffe400 0x100>;
+			};
+
 			ramc1: ramc at ffffe800 {
 				compatible = "atmel,at91sam9260-sdramc";
 				reg = <0xffffe800 0x200>;
 			};
 
+			smc1: smc1 at ffffea00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffea00 0x100>;
+			};
+
 			matrix: matrix at ffffec00 {
 				compatible = "atmel,at91sam9263-matrix", "syscon";
 				reg = <0xffffec00 0x200>;
-- 
1.9.1
