From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu,  9 Apr 2015 09:23:25 +0100
Subject: [PATCH 06/10] ARM: dts: apq8064: Add usb host support to CM QS-600
In-Reply-To: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428567674-10672-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428567805-10977-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Dechesne <nicolas.dechesne@linaro.org>

This patch adds device tree nodes to support two usb hosts on Compulab QS600 board.

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 5d75666..220ff19 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -40,6 +40,22 @@
 			};
 		};
 
+		usb3_phy:phy at 12520000 {
+			status = "ok";
+		};
+
+		usb4_phy:phy at 12530000 {
+			status = "ok";
+		};
+
+		usb3: usb at 12520000 {
+			status = "ok";
+		};
+
+		usb4: usb at 12530000 {
+			status = "ok";
+		};
+
 		amba {
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
-- 
1.9.1
