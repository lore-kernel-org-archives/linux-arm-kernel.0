From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 18 Nov 2013 19:18:57 +0200
Subject: [PATCH 4/6] watchdog: davinci: add "timeout-sec" property
In-Reply-To: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1384795139-19466-5-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Davinci WDT has been switched to use WDT core, it became able
to support timeout-sec property, so add it to it's binding description.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../devicetree/bindings/watchdog/davinci-wdt.txt   |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
index 75558cc..e450134 100644
--- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
@@ -4,9 +4,13 @@ Required properties:
 - compatible : Should be "ti,davinci-wdt"
 - reg : Should contain WDT registers location and length
 
+Optional properties:
+- timeout-sec : Contains the watchdog timeout in seconds
+
 Examples:
 
 wdt: wdt at 2320000 {
 	compatible = "ti,davinci-wdt";
 	reg = <0x02320000 0x80>;
+	timeout-sec = <30>;
 };
-- 
1.7.9.5
