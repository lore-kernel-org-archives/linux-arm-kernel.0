From: eric@anholt.net (Eric Anholt)
Date: Mon, 18 May 2015 12:43:39 -0700
Subject: [PATCH 7/7] ARM: bcm2835: Tie SPI clock to the core clock rate.
In-Reply-To: <1431978219-14226-1-git-send-email-eric@anholt.net>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
Message-ID: <1431978219-14226-8-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were previously using a fixed clock declared in the 2835 DT, but
it's actually the core clock, and it might not be the same if you had
adjusted it using the firmware's config.txt.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

This is the only patch in the series I haven't really tested, since I
don't have any SPI devices.

 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 53285a3..994c8e7 100644
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
