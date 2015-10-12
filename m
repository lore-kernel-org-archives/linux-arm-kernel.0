From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:13:05 +0300
Subject: [PATCH 36/37] ARM: dts: tegra20-seaboard: Fix regulator enable GPIO
 polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-37-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/tegra20-seaboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: linux-tegra at vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index aea8994b35f2..1d790cd59c21 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -850,7 +850,7 @@
 			regulator-name = "vdd_1v5";
 			regulator-min-microvolt = <1500000>;
 			regulator-max-microvolt = <1500000>;
-			gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
+			gpio = <&pmic 0 GPIO_ACTIVE_LOW>;
 		};
 
 		regulator at 2 {
-- 
2.4.9
