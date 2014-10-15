From: zyw@rock-chips.com (zyw at rock-chips.com)
Date: Wed, 15 Oct 2014 13:50:25 -0700
Subject: [PATCH 4/4] ARM: rockchip: add pmu-sram sub
In-Reply-To: <1413405987-16196-1-git-send-email-zyw@rock-chips.com>
References: <1413405987-16196-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1413406225-16366-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Zhong <zyw@rock-chips.com>

The pmu-sram is used to store resume code, suspend/resume need get the
address of it. Therefore add a node and documentation for it.

Signed-off-by: Tony Xie <xxx@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

 .../devicetree/bindings/arm/rockchip/pmu-sram.txt  |   15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt

diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt b/Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt
new file mode 100644
index 0000000..7a134cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt
@@ -0,0 +1,15 @@
+Rockchip SRAM for pmu:
+------------------------------
+
+The sram of pmu is used to store the function of resume from maskrom(the 1st
+level loader).
+
+Required node properties:
+- compatible : should be "rockchip,rk3288-pmu-sram"
+- reg : physical base address and the size of the registers window
+
+Example:
+	pmu_intmem at ff720000 {
+		compatible = "mmio-sram", "rockchip,rk3288-pmu-sram";
+		reg = <0xff720000 0x4000>;
+	};
-- 
1.7.9.5
