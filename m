From: sassmann@kpanic.de (Stefan Assmann)
Date: Mon, 14 Jul 2014 13:50:54 +0200
Subject: [PATCH RFC 1/2] dts: regulator-clk32kg should always be enabled
In-Reply-To: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
References: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
Message-ID: <1405338655-18415-2-git-send-email-sassmann@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock needs to be turned on for the wifi to work properly.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 arch/arm/boot/dts/twl6030.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 2e3bd31..e91e507 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -85,6 +85,7 @@
 
 	clk32kg: regulator-clk32kg {
 		compatible = "ti,twl6030-clk32kg";
+		regulator-always-on;
 	};
 
 	twl_usb_comparator: usb-comparator {
-- 
1.9.3
