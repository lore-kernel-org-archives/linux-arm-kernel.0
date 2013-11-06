From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Wed, 6 Nov 2013 13:32:56 +0200
Subject: Fwd: [PATCH 7/8] watchdog: davinci: add "clocks" property
In-Reply-To: <1383680783-12114-8-git-send-email-ivan.khoronzhuk@ti.com>
References: <1383680783-12114-8-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <527A28E8.4010204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone arch is using clocks in DT and source clock for watchdog
has to be specified, so add this to binding.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 .../devicetree/bindings/watchdog/davinci-wdt.txt   |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
index fddced9..4db4d0e 100644
--- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
@@ -7,6 +7,10 @@ Required properties:
 
 - reg : Should contain WDT registers location and length
 
+- clocks: phandle reference to the controller clock.
+	  Required only for Keystone arch.
+	  See clock-bindings.txt
+
 Optional properties:
 
 - timeout-sec:		Contains the watchdog timeout in seconds
@@ -21,4 +25,5 @@ wdt: wdt at 2320000 {
 	compatible = "ti,davinci-wdt";
 	reg = <0x02320000 0x80>;
 	timeout-sec = <30>;
+	clocks = <&clkwdtimer0>;
 };
-- 
1.7.9.5
