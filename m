From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Mar 2015 11:24:03 +0000
Subject: [PATCH 7/8] pcmcia: sa11xx_base.c: remove useless init/exit functions
In-Reply-To: <20150326112254.GZ8656@n2100.arm.linux.org.uk>
References: <20150326112254.GZ8656@n2100.arm.linux.org.uk>
Message-ID: <E1Yb5tL-0006IK-2Q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A library module is not required to have module init/exit functions.
Get rid of these unnecessary functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/sa11xx_base.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index 6e6336d47d4a..815b6950975c 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -259,16 +259,6 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 }
 EXPORT_SYMBOL(sa11xx_drv_pcmcia_probe);
 
-static int __init sa11xx_pcmcia_init(void)
-{
-	return 0;
-}
-fs_initcall(sa11xx_pcmcia_init);
-
-static void __exit sa11xx_pcmcia_exit(void) {}
-
-module_exit(sa11xx_pcmcia_exit);
-
 MODULE_AUTHOR("John Dorsey <john+@cs.cmu.edu>");
 MODULE_DESCRIPTION("Linux PCMCIA Card Services: SA-11xx core socket driver");
 MODULE_LICENSE("Dual MPL/GPL");
-- 
1.8.3.1
