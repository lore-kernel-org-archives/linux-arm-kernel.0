From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 19 Dec 2013 23:02:27 +0100
Subject: [PATCHv1 3/3] ARM: mvebu: Enable ISL12057 RTC chip in ReadyNAS 2120
 .dts file
In-Reply-To: <cover.1387490258.git.arno@natisbad.org>
References: <cover.1387490258.git.arno@natisbad.org>
Message-ID: <4db4d52b29b1b884503aafbe5d5bc7cac6bf4e4f.1387490258.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that support for Intersil ISL12057 RTC chip is available
upstream, let's enable it in NETGEAR ReadyNAS 2120 .dts file
so that the device stop believing it's the 70's.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index f048b4e..ff049ee 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -174,6 +174,11 @@
 				clock-frequency = <400000>;
 				status = "okay";
 
+				isl12057: isl12057 at 68 {
+					compatible = "isl,isl12057";
+					reg = <0x68>;
+				};
+
 				/* Controller for rear fan #1 of 3 (Protechnic
 				 * MGT4012XB-O20, 8000RPM) near eSATA port */
 				g762_fan1: g762 at 3e {
-- 
1.8.4.4
