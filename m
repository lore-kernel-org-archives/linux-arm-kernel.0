From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 28 Jan 2013 18:54:08 +0100
Subject: [PATCH 2/2] ARM: dts: OMAP3: Add NAND memory for Overo products
In-Reply-To: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1359395648-2137-3-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-tree support for the on-board NAND memory,
with corresponding partitions.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi |   49 ++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 81341fa..0efd6f3 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -33,6 +33,55 @@
 	};
 };
 
+&gpmc {
+	ranges = <0 0 0x30000000 0x00000004>;       /* CS0: NAND */
+
+	nand at 0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+
+		nand-bus-width = <16>;
+		ti,nand-ecc-opt = "sw";
+
+		gpmc,sync-clk = <0>;
+		gpmc,cs-on = <0>;
+		gpmc,cs-rd-off = <36>;
+		gpmc,cs-wr-off = <36>;
+		gpmc,adv-on = <6>;
+		gpmc,adv-rd-off = <24>;
+		gpmc,adv-wr-off = <36>;
+		gpmc,we-off = <30>;
+		gpmc,oe-off = <48>;
+		gpmc,access = <54>;
+		gpmc,rd-cycle = <72>;
+		gpmc,wr-cycle = <72>;
+		gpmc,wr-access = <30>;
+		gpmc,wr-data-mux-bus = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		xloader at 0 {
+			reg = <0x00000000 0x00080000>;
+		};
+
+		uboot at 80000 {
+			reg = <0x00080000 0x001c0000>;
+		};
+
+		ubootenv at 240000 {
+			reg = <0x00240000 0x00040000>;
+		};
+
+		linux at 280000 {
+			reg = <0x00280000 0x00400000>;
+		};
+
+		rootfs at 680000 {
+			reg = <0x00680000 0x1f980000>; /* 500 MB */
+		};
+	};
+};
+
 &i2c1 {
 	clock-frequency = <2600000>;
 
-- 
1.7.5.4
