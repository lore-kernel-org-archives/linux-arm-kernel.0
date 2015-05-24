From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 24 May 2015 20:50:18 +0200
Subject: [PATCH] ARM: BCM5301X: activate some additional options in pl310
 cache controller
Message-ID: <1432493418-12933-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the default Broadcom SDK the shared override is activated for this
cache controller, do the same in the upstream code. Data and
instruction prefetching is not activated by default for this cache
controller on the bcm53xx SoC, do it manually like it is done in the
vendor SDK.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 78aec62..7d1578a 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -78,6 +78,9 @@
 			compatible = "arm,pl310-cache";
 			reg = <0x2000 0x1000>;
 			cache-unified;
+			arm,shared-override;
+			arm,prefetch-data = <1>;
+			arm,prefetch-instr = <1>;
 			cache-level = <2>;
 		};
 	};
-- 
2.1.4
