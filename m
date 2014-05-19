From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Mon, 19 May 2014 20:57:06 +0800
Subject: [PATCH 2/3] Documentation: add Device tree bindings for Hisilicon
 hix5hd2 ethernet
In-Reply-To: <1400504227-12047-1-git-send-email-zhangfei.gao@linaro.org>
References: <1400504227-12047-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1400504227-12047-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../bindings/net/hisilicon-hix5hd2-net.txt         |   37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon-hix5hd2-net.txt

diff --git a/Documentation/devicetree/bindings/net/hisilicon-hix5hd2-net.txt b/Documentation/devicetree/bindings/net/hisilicon-hix5hd2-net.txt
new file mode 100644
index 0000000..16b1f0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon-hix5hd2-net.txt
@@ -0,0 +1,37 @@
+Hisilicon hix5hd2 Ethernet Controller
+
+Required properties:
+- compatible: should be "hisilicon,hix5hd2-mac".
+- reg : Specifies base physical address(s) and size of the device registers.
+  The first region is the mac register base and size.
+  The second region is external interface control register.
+- interrupts: Should contain the MAC interrupts
+- #address-cells: Must be <1>.
+- #size-cells: Must be <0>.
+- phy-mode: see ethernet.txt [1].
+- phy-handle: see ethernet.txt [1].
+- mac-address: see ethernet.txt [1].
+- clocks: clock phandle and specifier pair.
+
+- phy subnode: inherits from phy binding [2]
+
+[1] Documentation/devicetree/bindings/net/ethernet.txt
+[2] Documentation/devicetree/bindings/net/phy.txt
+
+Example:
+	gmac0: ethernet at f9840000 {
+		compatible = "hisilicon,hix5hd2-mac";
+		reg = <0xf9840000 0x1000>,<0xf984300c 0x4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy-handle = <&phy0>;
+		phy-mode = "mii";
+		mac-address = [00 00 00 00 00 00];
+		interrupts = <0 71 4>;
+		clocks = <&clock HIX5HD2_MAC0_CLK>;
+
+		phy0: ethernet-phy at 2 {
+			reg = <2>;
+			compatible = "ethernet-phy-ieee802.3-c22";
+		};
+	};
-- 
1.7.9.5
