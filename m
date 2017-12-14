From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu, 14 Dec 2017 09:08:40 +0000
Subject: [PATCH 2/3] ARM: dts: r8a7791: Correct critical CPU temperature
In-Reply-To: <1513242521-11236-1-git-send-email-chris.paterson2@renesas.com>
References: <1513242521-11236-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1513242521-11236-3-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R-Car M2W hardware manual states that Tc = ?40?C to +105?C. The
thermal sensor has an accuracy of ?5?C and there can be a temperature
difference of 1 or 2 degrees between Tjmax and the thermal sensor due
to the location of the latter.

This means that 95?C is a safer value to use.

Fixes: cac68a56e34b9810 ("ARM: dts: r8a7791: enable to use thermal-zone")
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index dfc1c406179fbf3a..008a260f86a565c6 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -92,7 +92,7 @@
 
 			trips {
 				cpu-crit {
-					temperature	= <115000>;
+					temperature	= <95000>;
 					hysteresis	= <0>;
 					type		= "critical";
 				};
-- 
1.9.1
