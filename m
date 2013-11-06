From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Wed, 6 Nov 2013 13:32:40 +0200
Subject: Fwd: [PATCH 5/8] watchdog: davinci: add "timeout-sec" property
In-Reply-To: <1383680783-12114-6-git-send-email-ivan.khoronzhuk@ti.com>
References: <1383680783-12114-6-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <527A28D8.9040901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Davinci WDT has been switched to use WDT core, it became able
to support timeout-sec property, so add it to it's binding description.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 .../devicetree/bindings/watchdog/davinci-wdt.txt   |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
index 75558cc..1668b6e 100644
--- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
@@ -4,9 +4,14 @@ Required properties:
 - compatible : Should be "ti,davinci-wdt"
 - reg : Should contain WDT registers location and length
 
+Optional properties:
+
+- timeout-sec:		Contains the watchdog timeout in seconds
+
 Examples:
 
 wdt: wdt at 2320000 {
 	compatible = "ti,davinci-wdt";
 	reg = <0x02320000 0x80>;
+	timeout-sec = <30>;
 };
-- 
1.7.9.5
