From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 19:12:22 -0300
Subject: [PATCH v2 9/9] ARM: orion5x: Update orion-wdt DT node
In-Reply-To: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377295942-5955-10-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the new DT binding, the 'reg' property requires
two cells, which mean: timer control register and watchdog
counter register respectively.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/orion5x.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 892c64e..0cce136 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -70,7 +70,8 @@
 
 		wdt at 20300 {
 			compatible = "marvell,orion-wdt";
-			reg = <0x20300 0x28>;
+			reg = <0x20300 0x4>,
+			      <0x20324 0x4>;
 			status = "okay";
 		};
 
-- 
1.8.1.5
