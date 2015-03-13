From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 13 Mar 2015 16:24:01 +0000
Subject: [PATCH 09/10] ARM: dt: dove: add video decoder power domain
 description
In-Reply-To: <20150312183020.GU8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Message-ID: <E1YWSNV-0006GP-DF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the description of the video decoder power domain to the PMU DT
entry.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 7e80407bdcf8..3dcf5322bf0e 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -387,6 +387,13 @@
 				interrupt-controller;
 				#interrupt-cells = <1>;
 				#reset-cells = <1>;
+
+				vpu_domain: vpu-domain {
+					#power-domain-cells = <0>;
+					marvell,pmu_pwr_mask = <0x00000008>;
+					marvell,pmu_iso_mask = <0x00000001>;
+					resets = <&pmu 16>;
+				};
 			};
 
 			thermal: thermal-diode at d001c {
-- 
1.8.3.1
