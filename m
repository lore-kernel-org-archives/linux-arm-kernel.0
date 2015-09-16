From: plaes@plaes.org (Priit Laes)
Date: Wed, 16 Sep 2015 10:59:40 +0300
Subject: [PATCH 4/4] ARM: dts: sun4i: gemei-g9: Use reg_ldo2 instead of
 reg_vcc3v0
In-Reply-To: <1442390380-1406-1-git-send-email-plaes@plaes.org>
References: <1442390380-1406-1-git-send-email-plaes@plaes.org>
Message-ID: <1442390380-1406-4-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apparently reg_ldo2 seems to be supplying the correct reference voltage
to ADC.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 0959c45..6f14743 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -116,7 +116,7 @@
 };
 
 &lradc {
-	vref-supply = <&reg_vcc3v0>;
+	vref-supply = <&reg_ldo2>;
 
 	status = "okay";
 
-- 
2.5.2
