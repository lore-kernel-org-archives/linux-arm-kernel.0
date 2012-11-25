From: tremyfr@yahoo.fr (Philippe Reynes)
Date: Sun, 25 Nov 2012 21:17:04 +0100
Subject: [PATCH 3/4] imx27-dt: configure i2c1 gpio on armadeus apf27
In-Reply-To: <1353874625-14754-1-git-send-email-tremyfr@yahoo.fr>
References: <1353874625-14754-1-git-send-email-tremyfr@yahoo.fr>
Message-ID: <1353874625-14754-4-git-send-email-tremyfr@yahoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
---
 arch/arm/mach-imx/imx27-dt.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index f212f81..2eb7014 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -17,6 +17,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
+#include <mach/iomux-mx27.h>
 #include <mach/mx27.h>
 
 static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
@@ -48,6 +49,10 @@ int apf27_lan8700_wakeup(struct phy_device *phydev)
 static void __init apf27_init(void)
 {
 	phy_register_fixup_for_id("imx27-fec.0-1:1f", apf27_lan8700_wakeup);
+
+	/* configure i2c1 gpio */
+	mxc_gpio_mode((GPIO_PORTD | GPIO_OUT | GPIO_PF | 17));
+	mxc_gpio_mode((GPIO_PORTD | GPIO_OUT | GPIO_PF | 18));
 }
 
 static void __init imx27_dt_init(void)
-- 
1.7.4.4
