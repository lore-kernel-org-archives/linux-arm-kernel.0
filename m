From: nm@ti.com (Nishanth Menon)
Date: Tue, 23 Jun 2015 11:15:14 -0500
Subject: [TMP PATCH V2 5/5] ARM: dts: am57xx-beagle-x15: Add wakeup irq for
 mcp79410
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
Message-ID: <1435076114-12416-6-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the support in the generic PM framework for wakeirq and capability
added to the rtc-ds1307 driver to support this, we can now define the
optional wakeup irq to allow the RTC to wakeup the system from low power
modes as part of suspend.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Please do not merge this patch -> since this needs to come via linux-omap
tree and also needs to be done with a few other changes on other peripherals.
This is meant for illustration only.

 arch/arm/boot/dts/am57xx-beagle-x15.dts |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index a42cc377a862..5c9ce2df260a 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -517,7 +517,8 @@
 	mcp_rtc: rtc at 6f {
 		compatible = "microchip,mcp7941x";
 		reg = <0x6f>;
-		interrupts = <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;  /* IRQ_SYS_1N */
+		interrupts-extended = <&crossbar_mpu GIC_SPI 2 IRQ_TYPE_EDGE_RISING>,
+				      <&dra7_pmx_core 0x424>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&mcp79410_pins_default>;
-- 
1.7.9.5
