From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  8 Jun 2012 17:02:01 +0300
Subject: [PATCH 3/7] arm/dts: omap4-sdp: Add fixed regulator to represent VBAT
In-Reply-To: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
References: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1339164125-32534-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are devices connected to VBAT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index e55d42a..4b51611 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -38,6 +38,14 @@
 		regulator-boot-on;
 	};
 
+	vbat: fixedregulator at 2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VBAT";
+		regulator-min-microvolt = <3750000>;
+		regulator-max-microvolt = <3750000>;
+		regulator-boot-on;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		debug0 {
-- 
1.7.8.6
