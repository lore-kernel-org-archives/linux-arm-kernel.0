From: chen.zhong@mediatek.com (Chen Zhong)
Date: Wed, 2 Aug 2017 11:17:17 +0800
Subject: [PATCH 1/4] dt-bindings: input: Add document bindings for
 mtk-pmic-keys
In-Reply-To: <1501643840-21485-1-git-send-email-chen.zhong@mediatek.com>
References: <1501643840-21485-1-git-send-email-chen.zhong@mediatek.com>
Message-ID: <1501643840-21485-2-git-send-email-chen.zhong@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree binding documentation for the MediaTek
pmic keys found on PMIC MT6397/MT6323.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 .../devicetree/bindings/input/mtk-pmic-keys.txt    |   36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
new file mode 100644
index 0000000..c5b230f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -0,0 +1,36 @@
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
+- mediatek,pwrkey-code: Keycode of pwrkey
+
+Optional Properties:
+- mediatek,homekey-code: Keycode of homekey
+- mediatek,long-press-mode: Long press key shutdown setting, 1 for
+	pwrkey only, 2 for pwrkey/homekey together, others for disabled.
+- mediatek,long-press-duration: Long press key shutdown duration setting,
+	0/1/2/3 for 8/11/14/5 seconds.
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
+			mediatek,pwrkey-code = <116>;
+			mediatek,homekey-code = <114>;
+			mediatek,long-press-mode = <1>;
+			mediatek,long-press-duration = <0>;
+		};
+	};
\ No newline at end of file
-- 
1.7.9.5
