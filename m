From: martyn.welch@collabora.co.uk (Martyn Welch)
Date: Fri,  4 Dec 2015 17:31:13 +0000
Subject: [PATCH 1/3] Device tree binding documentation for gpio-switch
In-Reply-To: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
References: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
Message-ID: <1449250275-23435-2-git-send-email-martyn.welch@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the gpio-switch binding. This binding
provides a mechanism to bind named links to gpio, with the primary
purpose of enabling standardised access to switches that might be standard
across a group of devices but implemented differently on each device.

Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 .../devicetree/bindings/misc/gpio-switch.txt       | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/gpio-switch.txt

diff --git a/Documentation/devicetree/bindings/misc/gpio-switch.txt b/Documentation/devicetree/bindings/misc/gpio-switch.txt
new file mode 100644
index 0000000..13528bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/gpio-switch.txt
@@ -0,0 +1,47 @@
+Device-Tree bindings for gpio attached switches.
+
+This provides a mechanism to provide a named link to specified gpios. This can
+be useful in instances such as when theres a need to monitor a switch, which is
+common across a family of devices, but attached to different gpios and even
+implemented in different ways on differnet devices.
+
+Required properties:
+	- compatible = "gpio-switch";
+
+Each signal is represented as a sub-node of "gpio-switch". The naming of
+sub-nodes is arbitrary.
+
+Required sub-node properties:
+
+	- label: Name to be given to gpio switch.
+	- gpios: OF device-tree gpio specification.
+
+Optional sub-node properties:
+
+	- read-only: Boolean flag to mark the gpio as read-only, i.e. the line
+	  should not be driven by the host.
+
+Example nodes:
+
+        gpio-switch {
+                compatible = "gpio-switch";
+
+                write-protect {
+                        label = "write-protect";
+                        gpios = <&gpx3 0 GPIO_ACTIVE_LOW>;
+                        read-only;
+                };
+
+                developer-switch {
+                        label = "developer-switch";
+                        gpios = <&gpx1 3 GPIO_ACTIVE_HIGH>;
+                        read-only;
+                };
+
+                recovery-switch {
+                        label = "recovery-switch";
+                        gpios = <&gpx0 7 GPIO_ACTIVE_LOW>;
+                        read-only;
+                };
+        };
+
-- 
2.1.4
