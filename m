From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 18 Oct 2012 21:04:06 -0300
Subject: [PATCH v2 2/2] mfd: Kconfig: Let MFD_SYSCON select REGMAP
In-Reply-To: <1350605046-21358-1-git-send-email-festevam@gmail.com>
References: <1350605046-21358-1-git-send-email-festevam@gmail.com>
Message-ID: <1350605046-21358-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Building multi_v7_defconfig for mx6 causes the following build error:

  CC      drivers/mfd/syscon.o
drivers/mfd/syscon.c:94: error: variable 'syscon_regmap_config' has initializer but incomplete type
drivers/mfd/syscon.c:95: error: unknown field 'reg_bits' specified in initializer
drivers/mfd/syscon.c:95: warning: excess elements in struct initializer
drivers/mfd/syscon.c:95: warning: (near initialization for 'syscon_regmap_config')
drivers/mfd/syscon.c:96: error: unknown field 'val_bits' specified in initializer
drivers/mfd/syscon.c:96: warning: excess elements in struct initializer
drivers/mfd/syscon.c:96: warning: (near initialization for 'syscon_regmap_config')
drivers/mfd/syscon.c:97: error: unknown field 'reg_stride' specified in initializer
drivers/mfd/syscon.c:97: warning: excess elements in struct initializer
drivers/mfd/syscon.c:97: warning: (near initialization for 'syscon_regmap_config')
drivers/mfd/syscon.c: In function 'syscon_probe':
drivers/mfd/syscon.c:124: error: invalid use of undefined type 'struct regmap_config'
drivers/mfd/syscon.c:125: error: implicit declaration of function 'devm_regmap_init_mmio'
drivers/mfd/syscon.c:126: warning: assignment makes pointer from integer without a cast

Fix it by selecting REGMAP option.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- No changes. Newly introduced in this series

 drivers/mfd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index acab3ef..ef56515 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1030,6 +1030,7 @@ config MFD_SYSCON
 	bool "System Controller Register R/W Based on Regmap"
 	depends on OF
 	select REGMAP_MMIO
+	select REGMAP
 	help
 	  Select this option to enable accessing system control registers
 	  via regmap.
-- 
1.7.9.5
