From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 14:34:49 +0200
Subject: [PATCH] arm64: dts: marvell: fix CP110 ICU node size
Message-ID: <20180705123449.6052-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 2f872ddcdb1e8e2186162616cea4581b8403849d upstream.

ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
specification).

Fixes: 6ef84a827c37 ("arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K")
Cc: stable at vger.kernel.org # 4.14.x
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---

Backport to 4.14 stable tree: the original patch did not applied
because of the effort of DT de-duplication that merged two files in one.


 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 9a7b63cd63a3..7c19f32d0f44 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -169,7 +169,7 @@
 
 			cpm_icu: interrupt-controller at 1e0000 {
 				compatible = "marvell,cp110-icu";
-				reg = <0x1e0000 0x10>;
+				reg = <0x1e0000 0x440>;
 				#interrupt-cells = <3>;
 				interrupt-controller;
 				msi-parent = <&gicp>;
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index faf28633a309..150e97a1dfea 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -169,7 +169,7 @@
 
 			cps_icu: interrupt-controller at 1e0000 {
 				compatible = "marvell,cp110-icu";
-				reg = <0x1e0000 0x10>;
+				reg = <0x1e0000 0x440>;
 				#interrupt-cells = <3>;
 				interrupt-controller;
 				msi-parent = <&gicp>;
-- 
2.14.1
