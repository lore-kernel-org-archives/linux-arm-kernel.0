From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 29 Dec 2017 17:17:16 +0100
Subject: [PATCH 2/4] arm64: dts: marvell: use mvebu-icu.h where possible
In-Reply-To: <20171229161718.8896-1-thomas.petazzoni@free-electrons.com>
References: <20171229161718.8896-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20171229161718.8896-3-thomas.petazzoni@free-electrons.com>
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
index 8a3cff9a7343..69ef3305b3e7 100644
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
index 8610163bb1a4..1458f312497b 100644
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
