From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 Jul 2012 14:06:12 +0100
Subject: [PATCH 9/9] ARM: ux500: Over-ride the DT device naming scheme for
 pinctrl
In-Reply-To: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1341493572-29735-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When pin control mapping tables are written the registered device
name is supplied for use in name-based searches within the pinctrl
driver. In the case of the DB8500 the string "pinctrl-db8500" is
used. However, when we register the driver with Device Tree, its
naming convention uses something that looks more like "pinctrl.2".

To work around the device naming inconsistencies between devices
registered via platform code and the ones registered by Device
Tree, we use AUXDATA to over-ride the Device Tree naming scheme.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index c12cd97..eb9198e 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -769,6 +769,7 @@ struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80128000, "nmk-i2c.2", NULL),
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80110000, "nmk-i2c.3", NULL),
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x8012a000, "nmk-i2c.4", NULL),
+	OF_DEV_AUXDATA("stericsson,nmk_pinctrl", 0, "pinctrl-db8500", NULL),
 	{},
 };
 
-- 
1.7.9.5
