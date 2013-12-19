From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 19 Dec 2013 23:02:15 +0100
Subject: [PATCHv1 2/3] ARM: mvebu: Enable ISL12057 RTC chip in ReadyNAS 104
 .dts file
In-Reply-To: <cover.1387490258.git.arno@natisbad.org>
References: <cover.1387490258.git.arno@natisbad.org>
Message-ID: <e43922d5bdddd660a69b4b54cfe69f6dffc2d508.1387490258.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that support for Intersil ISL12057 RTC chip is available
upstream, let's enable it in NETGEAR ReadyNAS 104 .dts file
so that the device stop believing it's the 70's.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 272e2e2..4e27587 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -117,6 +117,11 @@
 				clock-frequency = <100000>;
 				status = "okay";
 
+				isl12057: isl12057 at 68 {
+					compatible = "isl,isl12057";
+					reg = <0x68>;
+				};
+
 				g762: g762 at 3e {
 					compatible = "gmt,g762";
 					reg = <0x3e>;
-- 
1.8.4.4
