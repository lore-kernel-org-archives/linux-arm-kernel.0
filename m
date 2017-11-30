From: lukma@denx.de (Lukasz Majewski)
Date: Fri,  1 Dec 2017 00:51:39 +0100
Subject: [PATCH v4 4/5] ARM: ep93xx: ts72xx: cosmetic: Add some description to
 ts72xx code
In-Reply-To: <20171130235140.12243-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130235140.12243-1-lukma@denx.de>
Message-ID: <20171130235140.12243-5-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends readability of ts72xx.c code.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- New patch
Changes for v3:
- None
Changes to v4:
- Adjust the code to be applicable to linux-next/master
---
 arch/arm/mach-ep93xx/ts72xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 19b23c9a2efa..cf269b5397e5 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -31,6 +31,9 @@
 #include "soc.h"
 #include "ts72xx.h"
 
+/*************************************************************************
+ * IO map
+ *************************************************************************/
 static struct map_desc ts72xx_io_desc[] __initdata = {
 	{
 		.virtual	= (unsigned long)TS72XX_OPTIONS_VIRT_BASE,
@@ -210,10 +213,16 @@ static struct platform_device ts72xx_wdt_device = {
 	.num_resources	= ARRAY_SIZE(ts72xx_wdt_resources),
 };
 
+/*************************************************************************
+ * ETH
+ *************************************************************************/
 static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
 	.phy_id		= 1,
 };
 
+/*************************************************************************
+ * TS72XX support code
+ *************************************************************************/
 #if IS_ENABLED(CONFIG_FPGA_MGR_TS73XX)
 
 /* Relative to EP93XX_CS1_PHYS_BASE */
-- 
2.11.0
