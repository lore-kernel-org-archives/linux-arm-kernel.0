From: carlo@caione.org (Carlo Caione)
Date: Sat, 20 Sep 2014 19:06:51 +0200
Subject: [PATCH v4 3/4] ARM: DTS: meson: update DTSI to add watchdog node
In-Reply-To: <1411232812-11594-1-git-send-email-carlo@caione.org>
References: <1411232812-11594-1-git-send-email-carlo@caione.org>
Message-ID: <1411232812-11594-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/meson.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 55feb14..e6539ea 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -70,6 +70,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		wdt: watchdog at c1109900 {
+			compatible = "amlogic,meson6-wdt";
+			reg = <0xc1109900 0x8>;
+		};
+
 		uart_AO: serial at c81004c0 {
 			compatible = "amlogic,meson-uart";
 			reg = <0xc81004c0 0x14>;
-- 
1.9.1
