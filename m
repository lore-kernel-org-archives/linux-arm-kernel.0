From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 28 Nov 2016 13:15:28 +0100
Subject: [PATCH v2 2/2] ARM: dts: da850-lcdk: specify the maximum pixel clock
 rate for tilcdc
In-Reply-To: <1480335328-4010-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480335328-4010-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1480335328-4010-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to memory throughput constraints any display mode for which the
pixel clock rate exceeds the recommended value of 37500 KHz must be
filtered out.

Specify the max-pixelclock property for the display node for
da850-lcdk.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index d864f11..1283263 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -285,6 +285,7 @@
 
 &display {
 	status = "okay";
+	max-pixelclock = <37500>;
 };
 
 &display_out {
-- 
2.9.3
