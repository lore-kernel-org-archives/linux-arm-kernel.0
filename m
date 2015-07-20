From: eric@anholt.net (Eric Anholt)
Date: Mon, 20 Jul 2015 12:33:07 -0700
Subject: [PATCH v4 8/8] ARM: bcm2835: Use the firmware on rpi to get the EMMC
 clock.
In-Reply-To: <1437420787-32137-1-git-send-email-eric@anholt.net>
References: <1437420787-32137-1-git-send-email-eric@anholt.net>
Message-ID: <1437420787-32137-9-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the MMC frequency from 100Mhz to 250Mhz.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 0a32123..5d370cb 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -62,6 +62,7 @@
 &sdhci {
 	status = "okay";
 	bus-width = <4>;
+	clocks = <&firmware_clocks RPI_CLOCK_EMMC>;
 };
 
 &uart0 {
-- 
2.1.4
