From: hl@rock-chips.com (Lin Huang)
Date: Mon, 22 Aug 2016 11:36:20 +0800
Subject: [PATCH v7 4/8] Documentation: bindings: add dt documentation for dfi
 controller
In-Reply-To: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
References: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
Message-ID: <1471836984-6316-5-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the documentation for rockchip dfi devfreq-event driver.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v7:
-None

Changes in v6:
-None

Changes in v5:
-None

Changes in v4:
-None

Changes in v3:
-None

Changes in v2:
-None 

Changes in v1:
-None
 .../bindings/devfreq/event/rockchip-dfi.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
new file mode 100644
index 0000000..bf42255
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
@@ -0,0 +1,20 @@
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
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		compatible = "rockchip,rk3399-dfi";
+		rockchip,pmu = <&pmugrf>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+		status = "disabled";
+	};
+
-- 
2.6.6
