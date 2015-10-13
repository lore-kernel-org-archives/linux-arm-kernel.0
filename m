From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Tue, 13 Oct 2015 09:01:07 +0800
Subject: [PATCH v1 2/4] ASoC: RK3036: Add binding doc of inno-rk3036 codec
 driver
In-Reply-To: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1444698070-4191-3-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ZhengShunQian <zhengsq@rock-chips.com>

This patch add the binding document of inno-rk3036
audio codec driver.

Signed-off-by: ZhengShunQian <zhengsq@rock-chips.com>
---
 .../devicetree/bindings/sound/inno-rk3036.txt        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/inno-rk3036.txt

diff --git a/Documentation/devicetree/bindings/sound/inno-rk3036.txt b/Documentation/devicetree/bindings/sound/inno-rk3036.txt
new file mode 100644
index 0000000..57eb7bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/inno-rk3036.txt
@@ -0,0 +1,20 @@
+Inno audio codec for RK3036
+
+Inno audio codec is integrated inside RK3036 SoC.
+
+Required properties:
+- compatible : Should be "rk3036-codec".
+- reg : The registers of codec.
+- clock-names : Should be "acodec_pclk".
+- clocks : The clock of codec.
+- rockchip,grf : The phandle of grf device node.
+
+Example:
+
+	acodec: acodec-ana at 20030000 {
+		compatible = "rk3036-codec";
+		reg = <0x20030000 0x4000>;
+		rockchip,grf = <&grf>;
+		clock-names = "acodec_pclk";
+		clocks = <&cru ACLK_VCODEC>;
+	};
-- 
1.9.1
