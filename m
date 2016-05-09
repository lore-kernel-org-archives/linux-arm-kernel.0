From: petr@barix.com (Petr Kulhavy)
Date: Mon,  9 May 2016 16:35:21 +0200
Subject: [PATCH v5 3/4] ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entries for
 mcbsp0 and mcbsp1
In-Reply-To: <1462804522-29544-1-git-send-email-petr@barix.com>
References: <1462804522-29544-1-git-send-email-petr@barix.com>
Message-ID: <1462804522-29544-4-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OF_DEV_AUXDATA for mcbsp to be able to use clocks.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
v1: initial
v2: remove "-audio" postfix from the compatible string
v3: no change
v4: no change
v5: rebased to the current master of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git

 arch/arm/mach-davinci/da8xx-dt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 754f478110b4..ae2bf237e374 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -35,8 +35,11 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ns16550a", 0x01d0d000, "serial8250.2", NULL),
 	OF_DEV_AUXDATA("ti,davinci_mdio", 0x01e24000, "davinci_mdio.0", NULL),
 	OF_DEV_AUXDATA("ti,davinci-dm6467-emac", 0x01e20000, "davinci_emac.1",
-		       NULL),
-	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
+			NULL),
+	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0",
+			NULL),
+	OF_DEV_AUXDATA("ti,da850-mcbsp", 0x01d10000, "davinci-mcbsp.0", NULL),
+	OF_DEV_AUXDATA("ti,da850-mcbsp", 0x01d11000, "davinci-mcbsp.1", NULL),
 	{}
 };
 
-- 
1.9.1
