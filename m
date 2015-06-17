From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Jun 2015 15:03:33 +0200
Subject: [PATCH 2/5] ARM: shmobile: r8a7790 dtsi: Use "arm,gic-400" for GIC
In-Reply-To: <1434546216-10773-1-git-send-email-geert+renesas@glider.be>
References: <1434546216-10773-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1434546216-10773-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the "arm,cortex-a15-gic" compatible value for the GIC by
"arm,gic-400", as the R-Car Gen2 GIC is assumed to be a GIC-400.
This has been confirmed by reading the GICD_IIDR register (on r8a7791),
which reports 0x0200043b (GIC-400 = 0x02, ARM = 0x43b).

This has no effect on runtime behavior, as currently the GIC driver
treats both compatible values the same.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
You can read the GICD_IIDR register from U-Boot using

    md 0xf1001008 1
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 51ab8865ea37dc89..d24dcf231fff65ed 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -113,7 +113,7 @@
 	};
 
 	gic: interrupt-controller at f1001000 {
-		compatible = "arm,cortex-a15-gic";
+		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 		interrupt-controller;
-- 
1.9.1
