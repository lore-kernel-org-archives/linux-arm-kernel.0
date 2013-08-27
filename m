From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Aug 2013 11:34:34 -0300
Subject: [PATCH 10/15] ARM: mvebu: Add RSTOUT cell to system-controller DT node
In-Reply-To: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377614079-10000-11-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow watchdog to be enabled, add the register
to the (optional) second reg cell as specified by the binding.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 2 +-
 arch/arm/boot/dts/armada-xp.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index fa3dfc6..8f63e8e 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -34,7 +34,7 @@
 		internal-regs {
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
-				reg = <0x18200 0x100>;
+				reg = <0x18200 0x100>, <0x20704 0x4>;
 			};
 
 			L2: l2-cache {
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index f608412..c4d1219 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -87,7 +87,7 @@
 
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
-				reg = <0x18200 0x500>;
+				reg = <0x18200 0x500>, <0x20704 0x4>;
 			};
 
 			eth2: ethernet at 30000 {
-- 
1.8.1.5
