From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Dec 2012 13:22:06 +0000
Subject: [PATCH 4/8] ARM: ux500: Specify which IOS regulator to use for MMCI
In-Reply-To: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
References: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355404930-5691-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In an effort to move platform specific GPIO controlled regulators
out from platform code we've created a new mechanism to specify
them from within the MMCI driver using the supply name 'vmmc-ios'.
For that to happen when booting device tree, we need to supply it
in the MMCI (SDI) node.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/href.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/href.dtsi b/arch/arm/boot/dts/href.dtsi
index 592fb9d..f2c0f66 100644
--- a/arch/arm/boot/dts/href.dtsi
+++ b/arch/arm/boot/dts/href.dtsi
@@ -87,6 +87,7 @@
 			mmc-cap-sd-highspeed;
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
+			vqmmc-supply = <&vmmci>;
 
 			cd-gpios  = <&tc3589x_gpio 3 0x4>;
 
-- 
1.7.9.5
