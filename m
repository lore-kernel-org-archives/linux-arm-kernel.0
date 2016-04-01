From: petr@barix.com (Petr Kulhavy)
Date: Fri,  1 Apr 2016 17:42:05 +0200
Subject: [PATCH 3/3] ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for i2c1
In-Reply-To: <1459525325-25470-1-git-send-email-petr@barix.com>
References: <1459525325-25470-1-git-send-email-petr@barix.com>
Message-ID: <1459525325-25470-4-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OF_DEV_AUXDATA entry for second i2c on the da850 DT board driver
to use i2c clock.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index c4b5808ca7c1..880b94e64816 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -32,6 +32,7 @@ static void __init da8xx_init_irq(void)
 
 static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
+	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01e28000, "i2c_davinci.2", NULL),
 	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "davinci-wdt", NULL),
 	OF_DEV_AUXDATA("ti,da830-mmc", 0x01c40000, "da830-mmc.0", NULL),
 	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f00000, "ehrpwm", NULL),
-- 
1.9.1
