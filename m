From: eric@anholt.net (Eric Anholt)
Date: Fri, 26 Feb 2016 15:05:42 -0800
Subject: [PATCH 4/4] ARM: bcm2835: Enable SDHOST by default.
In-Reply-To: <1456527942-3045-1-git-send-email-eric@anholt.net>
References: <1456527942-3045-1-git-send-email-eric@anholt.net>
Message-ID: <1456527942-3045-5-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This improves read speed on my SD card (as reported by hdparm -t) from
10.15MB/sec to 16.70MB/sec.  Once we add slave DMA, we can get to
18.45MB/sec.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index b8efd41..65d3594 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -65,10 +65,18 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_gpio48>;
 
-	status = "okay";
 	bus-width = <4>;
 };
 
+&sdhost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhost_gpio48>;
+
+	bus-width = <4>;
+
+	status = "okay";
+};
+
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
-- 
2.7.0
