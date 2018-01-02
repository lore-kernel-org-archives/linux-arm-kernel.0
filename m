From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Jan 2018 15:55:55 +0100
Subject: [PATCH v2 5/8] arm64: dts: marvell: use mvebu-icu.h where possible
In-Reply-To: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
References: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20180102145558.9773-6-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Back when the ICU Device Tree binding was introduced, we could not use
mvebu-icu.h from the Device Tree files, because the DT files and
mvebu-icu.h were following different merge routes towards Linus
tree. Now that both have been merged, we can switch the Marvell Armada
CP110 Device Tree files to use the mvebu-icu.h header instead of
duplicating the ICU_GRP_NSR definition.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index a0b2cec2823f..f89053577bcc 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -44,7 +44,7 @@
  * Device Tree file for Marvell Armada CP110 Master.
  */
 
-#define ICU_GRP_NSR 0x0
+#include <dt-bindings/interrupt-controller/mvebu-icu.h>
 
 / {
 	cp110-master {
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 3eda62d482fc..a658b72b0229 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -44,7 +44,7 @@
  * Device Tree file for Marvell Armada CP110 Slave.
  */
 
-#define ICU_GRP_NSR 0x0
+#include <dt-bindings/interrupt-controller/mvebu-icu.h>
 
 / {
 	cp110-slave {
-- 
2.14.3
