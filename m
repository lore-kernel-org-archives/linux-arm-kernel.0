From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu, 14 Dec 2017 09:08:39 +0000
Subject: [PATCH 1/3] ARM: dts: r8a7790: Correct critical CPU temperature
In-Reply-To: <1513242521-11236-1-git-send-email-chris.paterson2@renesas.com>
References: <1513242521-11236-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1513242521-11236-2-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R-Car H2 hardware manual states that Tc = ?40?C to +105?C. The
thermal sensor has an accuracy of ?5?C and there can be a temperature
difference of 1 or 2 degrees between Tjmax and the thermal sensor due
to the location of the latter.

This means that 95?C is a safer value to use.

Fixes: a8b805f3606f7af7 ("ARM: dts: r8a7790: enable to use thermal-zone")
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 450bfc0e9796a557..ed9a68538a554001 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -168,7 +168,7 @@
 
 			trips {
 				cpu-crit {
-					temperature	= <115000>;
+					temperature	= <95000>;
 					hysteresis	= <0>;
 					type		= "critical";
 				};
-- 
1.9.1
