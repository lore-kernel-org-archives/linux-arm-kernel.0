From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 20 Aug 2013 09:36:27 -0300
Subject: [PATCH v2 2/4] ARM: mvebu: Add clock properties to Armada XP timer
 node
In-Reply-To: <1377002189-4398-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377002189-4398-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377002189-4398-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the addition of the Armada XP reference clock, we can now model
accurately the available clock inputs for the timer: namely, nbclk
and refclk. For each of this clock inputs we assign a name, for the
driver to select as appropriate.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 50e404e..2642f55 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -63,6 +63,8 @@
 
 			timer at 20300 {
 				compatible = "marvell,armada-xp-timer";
+				clocks = <&coreclk 2>, <&refclk>;
+				clock-names = "nbclk", "fixed";
 			};
 
 			coreclk: mvebu-sar at 18230 {
-- 
1.8.1.5
