From: alexanders83@web.de (Alexander Stein)
Date: Fri, 19 Dec 2014 09:51:38 +0100
Subject: [PATCH 1/3] ARM: at91/dt: add matrix node in at91sam9263 dtsi
In-Reply-To: <1418979100-13243-1-git-send-email-alexanders83@web.de>
References: <1418979100-13243-1-git-send-email-alexanders83@web.de>
Message-ID: <1418979100-13243-2-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add matrix node in at91sam9263 dtsi so that it can be referenced by other
devices.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index fd8d242..8cc5337 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -356,6 +356,11 @@
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
2.2.1
