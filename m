From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 16 Jun 2015 15:27:43 +0800
Subject: [PATCH v2 1/3] soc/rockchip: Add efuse bindings for Rockchip SoC
 efuse driver
In-Reply-To: <1434439665-27781-1-git-send-email-wxt@rock-chips.com>
References: <1434439665-27781-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1434439665-27781-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add efuse bindings for RK3066, RK3188, RK3288 and RK3368.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- Change the document decription.

 .../devicetree/bindings/fuse/rockchip,rockchip-efuse.txt   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fuse/rockchip,rockchip-efuse.txt

diff --git a/Documentation/devicetree/bindings/fuse/rockchip,rockchip-efuse.txt b/Documentation/devicetree/bindings/fuse/rockchip,rockchip-efuse.txt
new file mode 100644
index 0000000..f1f338e
--- /dev/null
+++ b/Documentation/devicetree/bindings/fuse/rockchip,rockchip-efuse.txt
@@ -0,0 +1,14 @@
+ROCKCHIP RK3066/RK3188/RK3288/RK3368 efuse block.
+
+Required properties:
+- compatible : should be: "rockchip,<name>-efuse"
+  "rockchip,rk3066-efuse": found on RK3066,RK3188,RK3288 and RK3368.
+- reg: Should contain 1 entry: the entry gives the physical address and length
+       of the fuse registers.
+
+Example:
+
+	efuse: efuse at ffb40000 {
+		compatible = "rockchip,rk3066-efuse";
+		reg = <0xffb40000 0x10000>;
+	};
-- 
1.9.1
