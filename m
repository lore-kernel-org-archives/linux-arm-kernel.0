From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Sun, 12 Jan 2014 15:22:49 +0200
Subject: [PATCH 06/12] ARM: dts: cm-t3x30: add twl4030 gpio pullups
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1389532975-28281-7-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pullup for twl4030 GPIO_0 used as MMC1 card detect signal.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index 4bcc639..a56d082 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -90,4 +90,6 @@
 
 &twl_gpio {
 	ti,use-leds;
+	/* pullups: BIT(0) */
+	ti,pullups = <0x000001>;
 };
-- 
1.7.5.4
