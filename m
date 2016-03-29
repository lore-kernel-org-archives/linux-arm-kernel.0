From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 29 Mar 2016 21:28:22 +0200
Subject: [PATCH] ARM: dts: omap3-sniper: Discard deprecated twl4030-power
 property
In-Reply-To: <1459279707-17611-1-git-send-email-contact@paulk.fr>
References: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Message-ID: <1459279707-17611-2-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This uses ti,system-power-controller instead of the deprecated ti,use_poweroff
property for powering off.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/omap3-sniper.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3-sniper.dts
index 78a1184..0222a33 100644
--- a/arch/arm/boot/dts/omap3-sniper.dts
+++ b/arch/arm/boot/dts/omap3-sniper.dts
@@ -154,9 +154,9 @@
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
 
-		power {
+		twl_power: power {
 			compatible = "ti,twl4030-power";
-			ti,use_poweroff;
+			ti,system-power-controller;
 		};
 	};
 };
-- 
2.7.4
