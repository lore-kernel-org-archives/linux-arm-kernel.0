From: andy.yan@rock-chips.com (Andy Yan)
Date: Thu,  8 Feb 2018 20:16:46 +0800
Subject: [PATCH v8 1/3] mtd: spi-nor: Bindings for Rockchip serial flash
 controller
In-Reply-To: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
References: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1518092206-3770-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Add binding document for the Rockchip serial flash controller.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Marek Vasut <marek.vasut@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/mtd/rockchip-sfc.txt       | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip-sfc.txt

diff --git a/Documentation/devicetree/bindings/mtd/rockchip-sfc.txt b/Documentation/devicetree/bindings/mtd/rockchip-sfc.txt
new file mode 100644
index 0000000..1e449b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/rockchip-sfc.txt
@@ -0,0 +1,31 @@
+Rockchip Serial Flash Controller
+
+Required properties:
+- compatible : Should be
+		"rockchip,rv1108-sfc", "rockchip,sfc" for ROCKCHIP RV1108.
+- address-cells : Should be 1.
+- size-cells : Should be 0.
+- clocks: Must contain two entries for each entry in clock-names.
+- clock-names: Shall be "sfc" for the transfer-clock, and "hsfc" for
+		the peripheral clock.
+- interrupts : Should contain the interrupt for the device.
+- reg: Physical base address of the controller and length of memory mapped.
+
+Optional properties:
+- rockchip,sfc-no-dma: Indicate the controller doesn't support DMA transfer.
+
+Example:
+nor_flash: sfc at 301c0000 {
+	compatible = "rockchip,rv1108-sfc", "rockchip,sfc";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+	clock-names = "sfc", "hsfc";
+	interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+	reg = <0x301c0000 0x1000>;
+	spi-nor at 0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <12000000>;
+		reg = <0>;
+	};
+};
-- 
2.7.4
