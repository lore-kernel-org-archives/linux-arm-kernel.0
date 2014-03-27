From: carlo@caione.org (Carlo Caione)
Date: Thu, 27 Mar 2014 18:02:38 +0100
Subject: [PATCH 1/2] ARM: sun7i/sun6i: dts: Fix IRQ number for sun6i NMI
 controller
In-Reply-To: <1395939759-11135-1-git-send-email-carlo@caione.org>
References: <1395939759-11135-1-git-send-email-carlo@caione.org>
Message-ID: <1395939759-11135-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans de Goede <hdegoede@redhat.com>

The IRQ line used in sun6i-a31.dtsi for the NMI controller is wrong.
This causes a IRQ storm since the NMI controller is repeatedly fired.
This patch fixes this problem assigning the correct IRQ number to the
NMI controller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 3b95cb5..38d43fe 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -195,7 +195,7 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x01f00c0c 0x38>;
-			interrupts = <0 0 4>;
+			interrupts = <0 32 4>;
 		};
 
 		pio: pinctrl at 01c20800 {
-- 
1.8.4.1
