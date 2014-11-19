From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 19 Nov 2014 16:57:34 +0100
Subject: [PATCH 7/7] [RFC] ARM: shmobile: r8a7740 dtsi: Add missing
 memory-controller node
In-Reply-To: <1416412654-6508-1-git-send-email-geert+renesas@glider.be>
References: <1416412654-6508-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1416412654-6508-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a memory-controller node for the DDR3 Bus State Controller (DBSC3),
which lies in the A4S PM domain.
There are no documented bindings for the DBSC3 yet (so far there's still
no need for a driver), but all of its properties follow the standard
conventions.

This has no visible effect for now, as A4S is never turned off because
its child domain A3SM contains the CPU core.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Question: Should I make dbsc3 a minimal node for now, i.e. retain only
	  its "compatible" and "power-domains" properties?
---
 arch/arm/boot/dts/r8a7740.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 95723764431a3e5d..173d4340bba1c4fa 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -37,6 +37,12 @@
 		      <0xc2000000 0x1000>;
 	};
 
+	dbsc3: memory-controller at fe400000 {
+		compatible = "renesas,dbsc3-r8a7740";
+		reg = <0xfe400000 0x400>;
+		power-domains = <&pd_a4s>;
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
