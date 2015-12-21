From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 21 Dec 2015 19:33:11 +0800
Subject: [PATCH 2/6] dt-bindings: soc: add document for rockchip reboot-mode
 driver
In-Reply-To: <1450697249-29994-1-git-send-email-andy.yan@rock-chips.com>
References: <1450697249-29994-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1450697591-30100-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding document for rockchip reboot-mode driver

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 .../bindings/soc/rockchip/rockchip,reboot-mode.txt | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip,reboot-mode.txt

diff --git a/Documentation/devicetree/bindings/soc/rockchip/rockchip,reboot-mode.txt b/Documentation/devicetree/bindings/soc/rockchip/rockchip,reboot-mode.txt
new file mode 100644
index 0000000..ede8509
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/rockchip/rockchip,reboot-mode.txt
@@ -0,0 +1,39 @@
+Rockchip reboot mode driver
+
+This driver get reboot mode arguments from userspace
+and stores it in special register. Then the bootloader
+will read it and take different action according the
+argument stored.
+
+Required properties:
+- compatible: should be "rockchip,reboot-mode"
+- regmap: this is phandle to the register map node
+- offset: offset in the register map for the storage register (in bytes)
+The rest of the properties should follow the generic reboot-mode discription
+found in ../../misc/reboot-mode.txt
+
+Examples:
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
+	};
-- 
1.9.1
