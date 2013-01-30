From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 Jan 2013 17:07:50 +0000
Subject: [PATCH 1/1] pinctrl: nomadik: Rename Device Tree compatible string
In-Reply-To: <51094E50.4000302@wwwdotorg.org>
References: <1359563102-5934-1-git-send-email-linus.walleij@stericsson.com>
 <51094E50.4000302@wwwdotorg.org>
Message-ID: <20130130170750.GA5217@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The preference is to use '-' instead of '_' in compatible strings.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi     |    2 +-
 arch/arm/mach-ux500/cpu-db8500.c  |    2 +-
 drivers/pinctrl/pinctrl-nomadik.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 3381ba6..b6256f3 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -171,7 +171,7 @@
 		};
 
 		pinctrl {
-			compatible = "stericsson,nmk_pinctrl";
+			compatible = "stericsson,nmk-pinctrl";
 			prcm = <&prcmu>;
 		};
 
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 5b286e0..b80ad96 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -285,7 +285,7 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80110000, "nmk-i2c.3", NULL),
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x8012a000, "nmk-i2c.4", NULL),
 	/* Requires device name bindings. */
-	OF_DEV_AUXDATA("stericsson,nmk_pinctrl", U8500_PRCMU_BASE,
+	OF_DEV_AUXDATA("stericsson,nmk-pinctrl", U8500_PRCMU_BASE,
 		"pinctrl-db8500", NULL),
 	/* Requires clock name and DMA bindings. */
 	OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80123000,
diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 4954302..2081931 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1847,7 +1847,7 @@ static struct pinctrl_desc nmk_pinctrl_desc = {
 
 static const struct of_device_id nmk_pinctrl_match[] = {
 	{
-		.compatible = "stericsson,nmk_pinctrl",
+		.compatible = "stericsson,nmk-pinctrl",
 		.data = (void *)PINCTRL_NMK_DB8500,
 	},
 	{},
-- 
1.7.9.5
