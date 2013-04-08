From: jon-hunter@ti.com (Jon Hunter)
Date: Sun, 7 Apr 2013 20:17:07 -0500
Subject: [PATCH 2/3] ARM: dts: Add NOR flash bindings for OMAP2420 H4
In-Reply-To: <1365383828-25627-1-git-send-email-jon-hunter@ti.com>
References: <1365383828-25627-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1365383828-25627-2-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-tree node for the 64MB NOR on the OMAP2420-H4 board.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap2420-h4.dts |   46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
index 9b0d077..68282ee 100644
--- a/arch/arm/boot/dts/omap2420-h4.dts
+++ b/arch/arm/boot/dts/omap2420-h4.dts
@@ -18,3 +18,49 @@
 		reg = <0x80000000 0x4000000>; /* 64 MB */
 	};
 };
+
+&gpmc {
+	ranges = <0 0 0x08000000 0x04000000>;
+
+	nor at 0,0 {
+		compatible = "cfi-flash";
+		linux,mtd-name= "intel,ge28f256l18b85";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0 0x04000000>;
+		bank-width = <2>;
+
+		gpmc,mux-add-data = <2>;
+		gpmc,cs-on-ns = <10>;
+		gpmc,cs-rd-off-ns = <160>;
+		gpmc,cs-wr-off-ns = <160>;
+		gpmc,adv-on-ns = <20>;
+		gpmc,adv-rd-off-ns = <50>;
+		gpmc,adv-wr-off-ns = <50>;
+		gpmc,oe-on-ns = <60>;
+		gpmc,oe-off-ns = <120>;
+		gpmc,we-on-ns = <60>;
+		gpmc,we-off-ns = <120>;
+		gpmc,rd-cycle-ns = <170>;
+		gpmc,wr-cycle-ns = <170>;
+		gpmc,access-ns = <150>;
+		gpmc,page-burst-access-ns = <10>;
+
+		partition at 0 {
+			label = "bootloader";
+			reg = <0 0x20000>;
+		};
+		partition at 0x20000 {
+			label = "params";
+			reg = <0x20000 0x20000>;
+		};
+		partition at 0x40000 {
+			label = "kernel";
+			reg = <0x40000 0x200000>;
+		};
+		partition at 0x240000 {
+			label = "file-system";
+			reg = <0x240000 0x3dc0000>;
+		};
+	};
+};
-- 
1.7.10.4
