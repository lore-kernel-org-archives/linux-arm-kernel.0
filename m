From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 May 2013 14:29:06 +0100
Subject: [PATCH 6/9] ARM: ux500: Provide device enumeration number suffix for
 SMSC911x
In-Reply-To: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1368019749-19455-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First Ethernet device has a ".0" appended onto the device name. It
appears that we need this in order to obtain the correct clock.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 8c2590c..718e707 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -276,7 +276,7 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x8012a000, "nmk-i2c.4", NULL),
 	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu",
 			&db8500_prcmu_pdata),
-	OF_DEV_AUXDATA("smsc,lan9115", 0x50000000, "smsc911x", NULL),
+	OF_DEV_AUXDATA("smsc,lan9115", 0x50000000, "smsc911x.0", NULL),
 	/* Requires device name bindings. */
 	OF_DEV_AUXDATA("stericsson,nmk-pinctrl", U8500_PRCMU_BASE,
 		"pinctrl-db8500", NULL),
-- 
1.7.10.4
