From: haas@computerlinguist.org (Michael Haas)
Date: Fri, 25 Mar 2016 20:04:06 +0100
Subject: [PATCH 2/3] sunxi: A20-OLinuXino-LIME2: Add usb-power-supply
In-Reply-To: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
Message-ID: <1458932647-24268-2-git-send-email-haas@computerlinguist.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20-OLinuXino-LIME2 uses the AXP209 PMIC. This patch adds the
corresponding usb-power-supply node to the DTS.
If CONFIG_AXP20X_POWER is set, this patch enables the /sys/class/power_supply/
diirectory.

Signed-off-by: Michael Haas <haas@computerlinguist.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index d5ff2e9..d370166 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -161,6 +161,9 @@
 				regulator-always-on;
 			};
 		};
+		usb_power_supply: usb_power_supply {
+			compatible = "x-powers,axp202-usb-power-supply";
+		};
 	};
 };
 
-- 
2.7.2
