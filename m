From: s-anna@ti.com (Suman Anna)
Date: Tue, 22 Apr 2014 17:23:37 -0500
Subject: [PATCH 3/3] ARM: dts: AM3517: Disable absent IPs inherited from OMAP3
In-Reply-To: <1398205417-1575-1-git-send-email-s-anna@ti.com>
References: <1398205417-1575-1-git-send-email-s-anna@ti.com>
Message-ID: <1398205417-1575-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM3517 inherits OMAP3 dts file, but does not have all the IPs
that are present on OMAP3. This patch disables the following
absent IPs for AM3517: Mailbox, IVA, MMU_ISP, MPU_IVA SmartReflex.

A label had to be added for IVA node in omap3.dtsi to be able to
get a reference to the node for disabling.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am3517.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi  |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 788391f..5a452fd 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -62,5 +62,21 @@
 	};
 };
 
+&iva {
+	status = "disabled";
+};
+
+&mailbox {
+	status = "disabled";
+};
+
+&mmu_isp {
+	status = "disabled";
+};
+
+&smartreflex_mpu_iva {
+	status = "disabled";
+};
+
 /include/ "am35xx-clocks.dtsi"
 /include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 5e5790f..f45f77f 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -61,7 +61,7 @@
 			ti,hwmods = "mpu";
 		};
 
-		iva {
+		iva: iva {
 			compatible = "ti,iva2.2";
 			ti,hwmods = "iva";
 
-- 
1.9.2
