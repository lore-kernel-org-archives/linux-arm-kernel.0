From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 28 Aug 2018 10:54:19 -0700
Subject: [PATCH v2 2/3] dt-bindings: net: dsa: Document B53 SRAB interrupts
 and registers
In-Reply-To: <20180828175420.7992-1-f.fainelli@gmail.com>
References: <20180828175420.7992-1-f.fainelli@gmail.com>
Message-ID: <20180828175420.7992-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the Broadcom roboswitch Switch Register Access Block interrupt
lines and additional register base addresses for port mux configuration
and SGMII status/configuration registers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/net/dsa/b53.txt       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/b53.txt b/Documentation/devicetree/bindings/net/dsa/b53.txt
index 1811e1972a7a..5f1029e853b8 100644
--- a/Documentation/devicetree/bindings/net/dsa/b53.txt
+++ b/Documentation/devicetree/bindings/net/dsa/b53.txt
@@ -46,6 +46,29 @@ Required properties:
       "brcm,bcm6328-switch"
       "brcm,bcm6368-switch" and the mandatory "brcm,bcm63xx-switch"
 
+Required properties for BCM585xx/586xx/88312 SoCs:
+
+ - reg: a total of 3 register base addresses, the first one must be the
+   Switch Register Access block base, the second is the port 5/4 mux
+   configuration register and the third one is the SGMII configuration
+   and status register base address.
+
+ - interrupts: a total of 13 interrupts must be specified, in the following
+   order: port 0-5, 7-8 link status change, then the integrated PHY interrupt,
+   then the timestamping interrupt and the sleep timer interrupts for ports
+   5,7,8.
+
+Optional properties for BCM585xx/586xx/88312 SoCs:
+
+  - reg-names: a total of 3 names matching the 3 base register address, must
+    be "srab", "mux_config" and "sgmii_config";
+
+  - interrupt-names: a total of 13 names matching the 13 interrupts specified
+    must be: "link_state_p0", "link_state_p1", "link_state_p2",
+    "link_state_p3", "link_state_p4", "link_state_p5", "link_state_p7",
+    "link_state_p8", "phy", "ts", "imp_sleep_timer_p5", "imp_sleep_timer_p7",
+    "imp_sleep_timer_p8"
+
 See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of additional
 required and optional properties.
 
-- 
2.17.1
