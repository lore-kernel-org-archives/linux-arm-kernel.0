From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:04:30 +0100
Subject: [PATCH 7/8] pcmcia: sa11xx_base.c: remove useless init/exit functions
In-Reply-To: <20150715180342.GB7557@n2100.arm.linux.org.uk>
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFR2k-0007Mm-0z@rmk-PC.arm.linux.org.uk>
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
2.1.0
