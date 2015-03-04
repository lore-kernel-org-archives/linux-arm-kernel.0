From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 17:15:48 +0100
Subject: [PATCH 2/2] ARM: at91/dt: sama5d4: fix lcdck parent clk
In-Reply-To: <1425485748-16759-1-git-send-email-nicolas.ferre@atmel.com>
References: <1425485748-16759-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1425485748-16759-2-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

lcdck takes mck (not smd) as its parent.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index a57b7965f98a..ee7575958cf7 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -482,7 +482,7 @@
 					lcdck: lcdck {
 						#clock-cells = <0>;
 						reg = <4>;
-						clocks = <&smd>;
+						clocks = <&mck>;
 					};
 
 					smdck: smdck {
-- 
2.1.3
