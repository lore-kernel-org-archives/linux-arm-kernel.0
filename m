From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:13:04 +0300
Subject: [PATCH 35/37] ARM: dts: tegra20-iris-512: Fix regulator enable GPIO
 polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-36-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/tegra20-iris-512.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: linux-tegra at vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>

diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts b/arch/arm/boot/dts/tegra20-iris-512.dts
index 1dd7d7bfdfcc..9b04a367575c 100644
--- a/arch/arm/boot/dts/tegra20-iris-512.dts
+++ b/arch/arm/boot/dts/tegra20-iris-512.dts
@@ -85,7 +85,7 @@
 			regulator-max-microvolt = <5000000>;
 			regulator-boot-on;
 			regulator-always-on;
-			gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
+			gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
 		};
 
 		vcc_sd_reg: regulator at 1 {
-- 
2.4.9
