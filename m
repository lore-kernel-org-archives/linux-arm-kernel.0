From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue, 22 Dec 2015 17:05:24 +0800
Subject: [PATCH v1 1/6] dt-bindings: misc: add document for reboot-mode driver
In-Reply-To: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1450775124-23966-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add device tree bindings document for reboot-mode driver

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v1: None

 .../devicetree/bindings/misc/reboot-mode.txt       | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/reboot-mode.txt

diff --git a/Documentation/devicetree/bindings/misc/reboot-mode.txt b/Documentation/devicetree/bindings/misc/reboot-mode.txt
new file mode 100644
index 0000000..082bc0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/reboot-mode.txt
@@ -0,0 +1,41 @@
+Generic reboot mode communication driver
+
+This driver get reboot mode arguments from userspace
+and stores it in special register or ram . Then the
+bootloader will read it and take different action
+according the argument stored.
+
+Required properties:
+        - compatible = "reboot-mode" or other vendor compatible string;
+
+Each mode is represented as a sub-node of reboot_mode:
+
+Subnode required properties:
+        - linux,mode: reboot mode command,such as "loader","recovery", "fastboot".
+        - linux,magic: magic number for the mode, this is vendor specific.
+
+example:
+	reboot_mode {
+		compatible = "rockchip,reboot-mode";
+		rockchip,regmap = <&pmu>;
+		offset = <0x40>;
+		loader {
+			linux,mode = "loader";
+			linux,magic = <0x5242C301>;
+		};
+
+		maskrom {
+			linux,mode = "maskrom";
+			linux,magic = <0x5242C302>;
+		};
+
+		recovery {
+			linux,mode = "recovery";
+			linux,magic = <0x5242C303>;
+		};
+
+		fastboot {
+			linux,mode = "fastboot";
+			linux,magic = <0x5242C309>;
+		};
+        };
-- 
1.9.1
