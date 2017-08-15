From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 15 Aug 2017 10:26:00 -0700
Subject: [PATCH 3/6] ARM: dts: cygnus: Enable Performance Monitoring Unit
In-Reply-To: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
References: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1502817964-8221-4-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Uy <jason.uy@broadcom.com>

Add PMU capability to Cygnus so trace and performance profiling
can be used.

Signed-off-by: Jason Uy <jason.uy@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 2077fee..bc08987 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -55,6 +55,11 @@
 
 	/include/ "bcm-cygnus-clock.dtsi"
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	core {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x19000000 0x1000000>;
-- 
2.5.0
