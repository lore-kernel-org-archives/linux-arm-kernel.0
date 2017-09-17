From: chen.zhong@mediatek.com (Chen Zhong)
Date: Sun, 17 Sep 2017 16:00:49 +0800
Subject: [PATCH v4 2/5] dt-bindings: input: Add document bindings for
 mtk-pmic-keys
In-Reply-To: <1505635252-27716-1-git-send-email-chen.zhong@mediatek.com>
References: <1505635252-27716-1-git-send-email-chen.zhong@mediatek.com>
Message-ID: <1505635252-27716-3-git-send-email-chen.zhong@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree binding documentation for the MediaTek
pmic keys found on PMIC MT6397/MT6323.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 .../devicetree/bindings/input/mtk-pmic-keys.txt    |   41 ++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
new file mode 100644
index 0000000..fd48ff7
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -0,0 +1,41 @@
+MediaTek MT6397/MT6323 PMIC Keys Device Driver
+
+There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
+and homekey. The key functions are defined as the subnode of the function
+node provided by MT6397/MT6323 PMIC that is being defined as one kind
+of Muti-Function Device (MFD)
+
+For MT6397/MT6323 MFD bindings see:
+Documentation/devicetree/bindings/mfd/mt6397.txt
+
+Required properties:
+- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+- linux,keycodes: Specifies the numeric keycode values to
+	be used for reporting keys presses. The array can
+	contain up to 2 entries.
+
+Optional Properties:
+- mediatek,wakeup-keys: Specifies each key can be used as a wakeup source
+	or not. This can be customized depends on board design.
+- wakeup-source: PMIC keys can be used as wakeup sources.
+- mediatek,long-press-mode: Long press key shutdown setting, 1 for
+	pwrkey only, 2 for pwrkey/homekey together, others for disabled.
+- debounce-interval: Long press key shutdown debouncing interval time
+	in seconds. 0/1/2/3 for 8/11/14/5 seconds. If not specified defaults to 0.
+
+Example:
+
+	pmic: mt6397 {
+		compatible = "mediatek,mt6397";
+
+		...
+
+		mt6397keys: mt6397keys {
+			compatible = "mediatek,mt6397-keys";
+			linux,keycodes = <116>, <114>;
+			mediatek,wakeup-keys = <1>, <0>;
+			wakeup-source;
+			mediatek,long-press-mode = <1>;
+			debounce-interval = <0>;
+		};
+	};
-- 
1.7.9.5
