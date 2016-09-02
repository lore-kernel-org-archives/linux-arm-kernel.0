From: hl@rock-chips.com (Lin Huang)
Date: Sat,  3 Sep 2016 05:08:41 +0800
Subject: [PATCH v9 1/5] Documentation: bindings: add dt documentation for dfi
 controller
In-Reply-To: <1472850525-25273-1-git-send-email-hl@rock-chips.com>
References: <1472850525-25273-1-git-send-email-hl@rock-chips.com>
Message-ID: <1472850525-25273-2-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the documentation for rockchip dfi devfreq-event driver.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v9:
- reorder compatible and reg

Changes in v8:
- delete a unuse blank line

Changes in v7:
- None

Changes in v6:
- None

Changes in v5:
- None

Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- None 

Changes in v1:
- None

 .../bindings/devfreq/event/rockchip-dfi.txt           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
new file mode 100644
index 0000000..f223313
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
@@ -0,0 +1,19 @@
+
+* Rockchip rk3399 DFI device
+
+Required properties:
+- compatible: Must be "rockchip,rk3399-dfi".
+- reg: physical base address of each DFI and length of memory mapped region
+- rockchip,pmu: phandle to the syscon managing the "pmu general register files"
+- clocks: phandles for clock specified in "clock-names" property
+- clock-names : the name of clock used by the DFI, must be "pclk_ddr_mon";
+
+Example:
+	dfi: dfi at 0xff630000 {
+		compatible = "rockchip,rk3399-dfi";
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		rockchip,pmu = <&pmugrf>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+		status = "disabled";
+	};
-- 
2.6.6
