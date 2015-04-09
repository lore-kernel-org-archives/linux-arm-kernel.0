From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu,  9 Apr 2015 09:23:32 +0100
Subject: [PATCH 07/10] ARM: dts: apq8064: Add USB OTG support for CM QS-600
In-Reply-To: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428567812-11019-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Dechesne <nicolas.dechesne@linaro.org>

This patch adds USB OTG support on USB1 for Compulab QS-600 Board.

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 220ff19..06307b9 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -40,6 +40,11 @@
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
@@ -48,6 +53,15 @@
 			status = "ok";
 		};
 
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
