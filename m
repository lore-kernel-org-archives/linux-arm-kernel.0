From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue, 22 Dec 2015 17:08:14 +0800
Subject: [PATCH v1 2/6] dt-bindings: soc: add document for rockchip
 reboot-mode driver
In-Reply-To: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1450775294-24028-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding document for rockchip reboot-mode driver

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v1: None

 .../bindings/soc/rockchip/rockchip,reboot-mode.txt | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip,reboot-mode.txt

diff --git a/Documentation/devicetree/bindings/soc/rockchip/rockchip,reboot-mode.txt b/Documentation/devicetree/bindings/soc/rockchip/rockchip,reboot-mode.txt
new file mode 100644
index 0000000..cdb5093
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
+			linux,magic = <BOOT_LOADER>;
+		};
+
+		maskrom {
+			linux,mode = "maskrom";
+			linux,magic = <BOOT_MASKROM>;
+		};
+
+		recovery {
+			linux,mode = "recovery";
+			linux,magic = <BOOT_RECOVERY>;
+		};
+
+		fastboot {
+			linux,mode = "fastboot";
+			linux,magic = <BOOT_FASTBOOT>;
+		};
+	};
-- 
1.9.1
