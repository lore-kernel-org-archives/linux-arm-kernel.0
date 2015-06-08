From: eric@anholt.net (Eric Anholt)
Date: Mon,  8 Jun 2015 16:59:00 -0700
Subject: [PATCH v3 7/7] ARM: bcm2835: Tie SPI clock to the core clock rate.
In-Reply-To: <1433807940-15328-1-git-send-email-eric@anholt.net>
References: <1433807940-15328-1-git-send-email-eric@anholt.net>
Message-ID: <1433807940-15328-7-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were previously using a fixed clock declared in the 2835 DT, but
it's actually the core clock, and it might not be the same if you had
adjusted it using the firmware's config.txt.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 9549eb8..0a32123 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -69,3 +69,7 @@
 		 <&firmware_clocks RPI_CLOCK_CORE>;
 	clock-names = "uartclk", "apb_pclk";
 };
+
+&spi {
+	clocks = <&firmware_clocks RPI_CLOCK_CORE>;
+};
-- 
2.1.4
