From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 9 Dec 2014 18:54:46 +0800
Subject: [PATCH 2/2] ARM: at91/dt: sama5d3: enable D2 as the heartbeat LED
In-Reply-To: <1418122486-23184-1-git-send-email-josh.wu@atmel.com>
References: <1418122486-23184-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1418122486-23184-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This D2 led is aviable for all sama5d3x-ek board. So make it as
heartbeat led.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 arch/arm/boot/dts/sama5d3xcm.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 962dc28..5a57c45 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -122,6 +122,7 @@
 		d2 {
 			label = "d2";
 			gpios = <&pioE 25 GPIO_ACTIVE_LOW>;	/* PE25, conflicts with A25, RXD2 */
+			linux,default-trigger = "heartbeat";
 		};
 	};
 };
-- 
1.9.1
