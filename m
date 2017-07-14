From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Fri, 14 Jul 2017 16:08:51 -0400
Subject: [PATCH v4 6/8] dt-bindings: watchdog: add documentation for TS4600
 watchdog controller
In-Reply-To: <20170714200853.10362-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714200853.10362-1-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <20170714200853.10362-7-sebastien.bourdelin@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dt-binding documentation for TS4600 watchdog controller.

Acked-by: Rob Herring <robh@kernel.org>
---
v4:
  - this documentation was previously merged with the watchdog driver
  and had been acked by Rob Herring, no changes have been done since.
Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
 .../devicetree/bindings/watchdog/ts4600-wdt.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
new file mode 100644
index 000000000000..7de00ceae341
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
@@ -0,0 +1,16 @@
+TS-4600 Technologic Systems Watchdog
+
+Required properties:
+- compatible: must be "technologic,ts4600-wdt"
+- reg: offset to the FPGA's watchdog register
+
+Optional property:
+- timeout-sec: contains the watchdog timeout in seconds.
+
+Example:
+
+watchdog {
+	compatible = "technologic,ts4600-wdt";
+	reg = <0x2a>;
+	timeout-sec = <10>;
+};
-- 
2.13.0
