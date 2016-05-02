From: petr@barix.com (Petr Kulhavy)
Date: Mon,  2 May 2016 15:40:39 +0200
Subject: [PATCH 2/2] ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for mmc1
In-Reply-To: <1462196439-4693-1-git-send-email-petr@barix.com>
References: <1462196439-4693-1-git-send-email-petr@barix.com>
Message-ID: <1462196439-4693-2-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da8xx-dt.c contained OF_DEV_AUXDATA entry for mmc0 only. The usage of
mmc1 was not possible from device tree because the probe was failing to
get the related MMC clock.

Add OF_DEV_AUXDATA entry for mmc1 in order to be able to use the mmc1
clocks and therefore the mmc1 interface.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index c4b5808ca7c1..115c316e9b76 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -34,6 +34,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
 	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "davinci-wdt", NULL),
 	OF_DEV_AUXDATA("ti,da830-mmc", 0x01c40000, "da830-mmc.0", NULL),
+	OF_DEV_AUXDATA("ti,da830-mmc", 0x01e1b000, "da830-mmc.1", NULL),
 	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f00000, "ehrpwm", NULL),
 	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f02000, "ehrpwm", NULL),
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f06000, "ecap", NULL),
-- 
1.9.1
