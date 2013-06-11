From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 11 Jun 2013 16:49:48 +0200
Subject: [PATCH 3/4] ARM: dts: omap3-tobi: Correct polarity for GPIO LED
In-Reply-To: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch>
References: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1370962189-9689-4-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LED is active low, not active high.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-tobi.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index dea726f..1458591 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -20,7 +20,7 @@
 		compatible = "gpio-leds";
 		heartbeat {
 			label = "overo:red:gpio21";
-			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
-- 
1.7.5.4
