From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 23 Feb 2015 07:55:52 +0000
Subject: [PATCH 08/12] ARM: DT: apq8064: Add USB OTG support for CM QS-600
In-Reply-To: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1424678152-13266-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Dechesne <nicolas.dechesne@linaro.org>

This patch adds USB OTG support on USB1 for Compulab QS-600 Board.

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index af2e075..6349f24 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -41,6 +41,11 @@
 			};
 		};
 
+		/* OTG */
+		usb1_phy:phy at 12500000 {
+			status = "ok";
+		};
+
 		usb3_phy:phy at 12520000 {
 			status = "ok";
 		};
@@ -48,7 +53,16 @@
 		usb4_phy:phy at 12530000 {
 			status = "ok";
 		};
-		
+
+		gadget1:gadget at 12500000 {
+			status = "ok";
+		};
+
+		/* OTG */
+		usb1: usb at 12500000 {
+			status = "ok";
+		};
+
 		usb3: usb at 12520000 {
 			status = "ok";
 		};
-- 
1.9.1
