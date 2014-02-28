From: yegorslists@googlemail.com (yegorslists at googlemail.com)
Date: Fri, 28 Feb 2014 08:19:04 +0100
Subject: [PATCH] ARM: dts: am335x-evmsk: enable USB1
Message-ID: <1393571944-10438-1-git-send-email-yegorslists@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Enable second USB channel and set it into 'host' mode.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 486880b..40a66bd 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -342,9 +342,18 @@
 		status = "okay";
 	};
 
+	usb-phy at 47401b00 {
+		status = "okay";
+	};
+
 	usb at 47401000 {
 		status = "okay";
 	};
+
+	usb at 47401800 {
+		status = "okay";
+		dr_mode = "host";
+	};
 };
 
 &epwmss2 {
-- 
1.7.7
