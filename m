From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 28 Jan 2015 19:38:59 +0100
Subject: [PATCH 1/5] ARM: at91/dt: add matrix node in at91sam9263 dtsi
In-Reply-To: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1422470343-25981-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Stein <alexanders83@web.de>

Add matrix node in at91sam9263 dtsi so that it can be referenced by other
devices.

Signed-off-by: Alexander Stein <alexanders83@web.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 5e548ad..ceb0254 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -366,6 +366,11 @@
 				reg = <0xffffe800 0x200>;
 			};
 
+			matrix: matrix at ffffec00 {
+				compatible = "atmel,at91sam9263-matrix", "syscon";
+				reg = <0xffffec00 0x200>;
+			};
+
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
-- 
1.9.1
