From: mporter@linaro.org (Matt Porter)
Date: Wed, 12 Mar 2014 09:14:39 -0400
Subject: [PATCH] ARM: dts: bcm28155-ap: leave camldo1 on to fix reboot
Message-ID: <1394630079-12063-1-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM28155-AP board has a bootloader that expects the camldo1
regulator to be enabled on entry. Currently, the camldo1 regulator
is disabled when no longer in use as is the case during a reboot /
warm reset. This causes the early bootloader to hang upon entry. Add
regulator-always-on to the camldo1 constraint to fix reboot.

Reported-by: Alex Elder <elder@linaro.org>
Signed-off-by: Matt Porter <mporter@linaro.org>
---
[Depends on BCM59056 regulator series dts support:
 http://www.gossamer-threads.com/lists/linux/kernel/1885489]

 arch/arm/boot/dts/bcm28155-ap.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 99ff0c1..cc1303c 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -94,6 +94,7 @@
 		camldo1_reg: camldo1 {
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
 		};
 
 		sdldo_reg: sdldo {
-- 
1.8.4
