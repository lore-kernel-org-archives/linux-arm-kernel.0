From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed, 18 Nov 2015 17:53:30 +0800
Subject: [PATCH v3 2/5] dt-bindings: soc: add document for rockchip reboot
 notifier driver
In-Reply-To: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1447840410-19794-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree binding document for rockchip reboot nofifier driver

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v3:
 - add dt binding

Changes in v2: None

 .../bindings/soc/rockchip/rockchip-reboot.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip-reboot.txt

diff --git a/Documentation/devicetree/bindings/soc/rockchip/rockchip-reboot.txt b/Documentation/devicetree/bindings/soc/rockchip/rockchip-reboot.txt
new file mode 100644
index 0000000..6f69c8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/rockchip/rockchip-reboot.txt
@@ -0,0 +1,18 @@
+Rockchip reboot notifier driver
+
+This driver get reboot mode arguments from userspace
+and stores it in special register. Then the bootloader
+will read it and take different action according the
+argument stored.
+
+Required properties:
+- compatible: should be "rockchip,reboot"
+- regmap: this is phandle to the register map node
+- offset: offset in the register map for the storage register (in bytes)
+
+Examples:
+	reboot {
+	   compatible = "rockchip,reboot";
+	   regmap = <&pmu>;
+	   offset = <0x94>;
+	};
-- 
1.9.1
