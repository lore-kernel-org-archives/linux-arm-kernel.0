From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Nov 2015 13:36:53 +0100
Subject: [PATCH 2/6] ARM: shmobile: r8a7740 dtsi: Use "arm,pl390" for GIC
In-Reply-To: <1448023017-21816-1-git-send-email-geert+renesas@glider.be>
References: <1448023017-21816-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1448023017-21816-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the "arm,cortex-a9-gic" compatible value for the GIC by
"arm,pl390", as the documentation states it is a PL390.
This has been confirmed by reading the GICD_IIDR register, which reports
0x0000043b (PL390 = 0x00, ARM = 0x43b).

This has no effect on runtime behavior, as currently the GIC driver
treats both compatible values the same.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
You can read the GICD_IIDR register from Hermit using

    frob
    peek 0xc2800008
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 4d58cdc3a026b2a4..08846c72cf1a64a3 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -39,7 +39,7 @@
 	};
 
 	gic: interrupt-controller at c2800000 {
-		compatible = "arm,cortex-a9-gic";
+		compatible = "arm,pl390";
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0xc2800000 0x1000>,
-- 
1.9.1
