From: zonque@gmail.com (Daniel Mack)
Date: Sun,  4 Aug 2013 16:13:20 +0200
Subject: [PATCH 1/2] ARM: pxa: add OF_DEV_AUXDATA for ssp ports
Message-ID: <1375625601-32257-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed until we switch over to the common clk framework.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---

Haojian, note that these two patches apply on top of the PXA-specific last
two ones of my pxa-gpio series.

Thanks,
Daniel

 arch/arm/mach-pxa/pxa-dt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index f6a2c4b..3e1ec71 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -33,6 +33,10 @@ static const struct of_dev_auxdata pxa3xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,pxa-i2c",		0x40301680, "pxa2xx-i2c.0", NULL),
 	OF_DEV_AUXDATA("mrvl,pwri2c",		0x40f500c0, "pxa3xx-i2c.1", NULL),
 	OF_DEV_AUXDATA("marvell,pxa3xx-nand",	0x43100000, "pxa3xx-nand", NULL),
+	OF_DEV_AUXDATA("mrvl,pxa27x-ssp",	0x41000000, "pxa27x-ssp.0", NULL),
+	OF_DEV_AUXDATA("mrvl,pxa27x-ssp",	0x41700000, "pxa27x-ssp.1", NULL),
+	OF_DEV_AUXDATA("mrvl,pxa27x-ssp",	0x41900000, "pxa27x-ssp.2", NULL),
+	OF_DEV_AUXDATA("mrvl,pxa27x-ssp",	0x41a00000, "pxa27x-ssp.3", NULL),
 	{}
 };
 
-- 
1.8.3.1
