From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 25 Oct 2014 17:32:42 +0200
Subject: [PATCHv0] arm: mvebu: enable rear eSATA ports of NETGEAR ReadyNAS 2120
Message-ID: <f3876c7a9ef11eb758b9df18c671ee740b8be614.1414250947.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


NETGEAR ReadyNAS 2120 supports its four main SATA disks via 2
Marvell 88SE9170 SATA controllers connected on the PCIe bus
of the the SoC. The two eSATA ports available at the rear of
the device are handled by the native SATA controller of the
Armada XP SoC powering the NAS. This patch enables the SoC
SATA controller in the .dts file to make those two rear ports
available.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 7d8f32873e82..e3a8c456bb84 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -137,6 +137,12 @@
 				};
 			};
 
+			/* Two rear eSATA ports */
+			sata at a0000 {
+				nr-ports = <2>;
+				status = "okay";
+			};
+
 			serial at 12000 {
 				status = "okay";
 			};
-- 
2.1.1
