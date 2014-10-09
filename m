From: johan@kernel.org (Johan Hovold)
Date: Thu,  9 Oct 2014 21:06:34 +0200
Subject: [PATCH 12/12] ARM: dts: am335x-bone-common: enable power off and rtc
 wake up
In-Reply-To: <1412881594-25678-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
Message-ID: <1412881594-25678-13-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure the RTC as system-power controller, which allows the system to
be powered off as well as woken up again on subsequent RTC alarms.

Note that the PMIC needs to be put in SLEEP (rather than OFF) mode to
maintain RTC power. Specifically, this means that the PMIC
ti,pmic-shutdown-controller property must be left unset in order to be
able to wake up on RTC alarms.

Tested on BeagleBone Black (rev A5).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index bde1777b62be..d0693bea9580 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -298,3 +298,7 @@
 	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
 };
+
+&rtc {
+	ti,system-power-controller;
+};
-- 
2.0.4
