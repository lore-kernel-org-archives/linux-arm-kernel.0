From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:45:04 +0800
Subject: [PATCH 08/11] ARM: dts: imx28-evk: add heartbeat gpio-leds
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add heartbeat gpio-leds for imx28-evk board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 17bf6cf..a551295 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -182,4 +182,14 @@
 		saif-controllers = <&saif0 &saif1>;
 		audio-codec = <&sgtl5000>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user {
+			label = "Heartbeat";
+			gpios = <&gpio3 5 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
 };
-- 
1.7.5.4
