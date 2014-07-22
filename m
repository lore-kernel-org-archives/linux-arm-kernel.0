From: marek@goldelico.com (Marek Belisko)
Date: Tue, 22 Jul 2014 21:30:14 +0200
Subject: [PATCH v2 1/7] arm: dts: omap3-gta04: Add nand support
In-Reply-To: <1406057420-22269-1-git-send-email-marek@goldelico.com>
References: <1406057420-22269-1-git-send-email-marek@goldelico.com>
Message-ID: <1406057420-22269-2-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed sections to enable nand support on
gta04 board.

Add nand partitions information.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 021311f..7d7ddd7 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -309,3 +309,57 @@
 		};
 	};
 };
+
+&gpmc {
+	ranges = <0 0 0x30000000 0x04>; /* CS0: NAND */
+
+	nand at 0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		nand-bus-width = <16>;
+		ti,nand-ecc-opt = "bch8";
+
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		gpmc,device-width = <2>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		x-loader at 0 {
+			label = "X-Loader";
+			reg = <0 0x80000>;
+		};
+
+		bootloaders at 80000 {
+			label = "U-Boot";
+			reg = <0x80000 0x1e0000>;
+		};
+
+		bootloaders_env at 260000 {
+			label = "U-Boot Env";
+			reg = <0x260000 0x20000>;
+		};
+
+		kernel at 280000 {
+			label = "Kernel";
+			reg = <0x280000 0x400000>;
+		};
+
+		filesystem at 680000 {
+			label = "File System";
+			reg = <0x680000 0xf980000>;
+		};
+	};
+};
-- 
1.9.1
