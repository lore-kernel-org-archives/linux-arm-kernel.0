From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Dec 2012 13:22:04 +0000
Subject: [PATCH 2/8] ARM: ux500: Set correct MMCI regulator voltages in the
 ux5x0 Device Tree
In-Reply-To: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
References: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355404930-5691-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the voltage specified by the mmci regulator node in Device
Tree. Despite the MMC subsystem insisting on v3.3, we actually only
offer v2.9, and not v2.6 which must have actually been a typo.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 9f55363..6b1aa6d 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -634,7 +634,7 @@
 			compatible = "regulator-gpio";
 
 			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2600000>;
+			regulator-max-microvolt = <2900000>;
 			regulator-name = "mmci-reg";
 			regulator-type = "voltage";
 
-- 
1.7.9.5
