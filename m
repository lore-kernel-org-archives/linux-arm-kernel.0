From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  6 May 2013 17:33:38 +0200
Subject: [PATCH v3 5/7] ARM: kirkwood: remove legacy mv643xx_eth board setup
In-Reply-To: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1367854420-8006-6-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DT support for mv643xx_eth we do not need legacy platform_data
based setup for DT enabled boards. This patch removes eth setup
for all kirkwood DT board files.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jamie Lentin <jm@lentin.co.uk>
Cc: Michael Walle <michael@walle.cc>
Cc: Eric Hutter <hutter.eric@gmail.com>
Cc: Joshua Coombs <josh.coombs@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Simon Baatz <gmbnomis@gmail.com>
Cc: Alan M Butler <alanbutty12@gmail.com>
Cc: Nigel Roberts <nigel@nobiscuit.com>
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>
Cc: Stefan Peter <s.peter@mpl.ch>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: netdev at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-kirkwood/board-dnskw.c          |    7 -------
 arch/arm/mach-kirkwood/board-dockstar.c       |    9 ---------
 arch/arm/mach-kirkwood/board-dreamplug.c      |   14 --------------
 arch/arm/mach-kirkwood/board-goflexnet.c      |    9 ---------
 arch/arm/mach-kirkwood/board-guruplug.c       |   14 --------------
 arch/arm/mach-kirkwood/board-ib62x0.c         |    9 ---------
 arch/arm/mach-kirkwood/board-iconnect.c       |    6 ------
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   16 ----------------
 arch/arm/mach-kirkwood/board-km_kirkwood.c    |    7 -------
 arch/arm/mach-kirkwood/board-lsxl.c           |   12 ------------
 arch/arm/mach-kirkwood/board-mplcec4.c        |   11 -----------
 arch/arm/mach-kirkwood/board-ns2.c            |   13 -------------
 arch/arm/mach-kirkwood/board-openblocks_a6.c  |    9 ---------
 arch/arm/mach-kirkwood/board-readynas.c       |    6 ------
 arch/arm/mach-kirkwood/board-ts219.c          |   13 -------------
 arch/arm/mach-kirkwood/board-usi_topkick.c    |    9 ---------
 16 files changed, 0 insertions(+), 164 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
index a1aa87f..2af7a95 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -14,14 +14,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data dnskw_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
 /* Register any GPIO for output and set the value */
 static void __init dnskw_gpio_register(unsigned gpio, char *name, int def)
 {
@@ -36,8 +31,6 @@ static void __init dnskw_gpio_register(unsigned gpio, char *name, int def)
 
 void __init dnskw_init(void)
 {
-	kirkwood_ge00_init(&dnskw_ge00_data);
-
 	/* Set NAS to turn back on after a power failure */
 	dnskw_gpio_register(37, "dnskw:power:recover", 1);
 }
diff --git a/arch/arm/mach-kirkwood/board-dockstar.c b/arch/arm/mach-kirkwood/board-dockstar.c
index d7196db..b78032e 100644
--- a/arch/arm/mach-kirkwood/board-dockstar.c
+++ b/arch/arm/mach-kirkwood/board-dockstar.c
@@ -16,17 +16,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mv643xx_eth.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data dockstar_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
 void __init dockstar_dt_init(void)
 {
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_ge00_init(&dockstar_ge00_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index 0903242..cb7823d 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -13,23 +13,9 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data dreamplug_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
-static struct mv643xx_eth_platform_data dreamplug_ge01_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
-};
-
 void __init dreamplug_init(void)
 {
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_ge00_init(&dreamplug_ge00_data);
-	kirkwood_ge01_init(&dreamplug_ge01_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-goflexnet.c b/arch/arm/mach-kirkwood/board-goflexnet.c
index 9db979a..4213e20 100644
--- a/arch/arm/mach-kirkwood/board-goflexnet.c
+++ b/arch/arm/mach-kirkwood/board-goflexnet.c
@@ -18,17 +18,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mv643xx_eth.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data goflexnet_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
 void __init goflexnet_init(void)
 {
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_ge00_init(&goflexnet_ge00_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-guruplug.c b/arch/arm/mach-kirkwood/board-guruplug.c
index a857163..d515f64 100644
--- a/arch/arm/mach-kirkwood/board-guruplug.c
+++ b/arch/arm/mach-kirkwood/board-guruplug.c
@@ -11,23 +11,9 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data guruplug_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
-static struct mv643xx_eth_platform_data guruplug_ge01_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
-};
-
 void __init guruplug_dt_init(void)
 {
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_ge00_init(&guruplug_ge00_data);
-	kirkwood_ge01_init(&guruplug_ge01_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
index 9a857ae..6082373 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -13,17 +13,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mv643xx_eth.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data ib62x0_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
 void __init ib62x0_init(void)
 {
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_ge00_init(&ib62x0_ge00_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index c8ebde4..045668c 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -11,16 +11,10 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/mv643xx_eth.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data iconnect_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(11),
-};
-
 void __init iconnect_init(void)
 {
-	kirkwood_ge00_init(&iconnect_ge00_data);
 }
 
 static int __init iconnect_pci_init(void)
diff --git a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
index e5f7041..dc86cf7 100644
--- a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
+++ b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
@@ -10,25 +10,9 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data iomega_ix2_200_ge00_data = {
-	.phy_addr       = MV643XX_ETH_PHY_NONE,
-	.speed          = SPEED_1000,
-	.duplex         = DUPLEX_FULL,
-};
-
-static struct mv643xx_eth_platform_data iomega_ix2_200_ge01_data = {
-        .phy_addr       = MV643XX_ETH_PHY_ADDR(11),
-};
-
 void __init iomega_ix2_200_init(void)
 {
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_ge00_init(&iomega_ix2_200_ge00_data);
-	kirkwood_ge01_init(&iomega_ix2_200_ge01_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-km_kirkwood.c b/arch/arm/mach-kirkwood/board-km_kirkwood.c
index 44e4605..6b8464b 100644
--- a/arch/arm/mach-kirkwood/board-km_kirkwood.c
+++ b/arch/arm/mach-kirkwood/board-km_kirkwood.c
@@ -14,15 +14,10 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mv643xx_eth.h>
 #include <linux/clk.h>
 #include <linux/clk-private.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data km_kirkwood_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
 void __init km_kirkwood_init(void)
 {
 	struct clk *sata_clk;
@@ -39,6 +34,4 @@ void __init km_kirkwood_init(void)
 	sata_clk = clk_get_sys("sata_mv.0", "1");
 	if (!IS_ERR(sata_clk))
 		sata_clk->flags |= CLK_IGNORE_UNUSED;
-
-	kirkwood_ge00_init(&km_kirkwood_ge00_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-lsxl.c b/arch/arm/mach-kirkwood/board-lsxl.c
index 4ec8b7a..1cbcd56 100644
--- a/arch/arm/mach-kirkwood/board-lsxl.c
+++ b/arch/arm/mach-kirkwood/board-lsxl.c
@@ -14,17 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mv643xx_eth.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data lsxl_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
-static struct mv643xx_eth_platform_data lsxl_ge01_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
 /*
  * On the LS-XHL/LS-CHLv2, the shutdown process is following:
  * - Userland monitors key events until the power switch goes to off position
@@ -44,9 +35,6 @@ void __init lsxl_init(void)
 	 * Basic setup. Needs to be called early.
 	 */
 
-	kirkwood_ge00_init(&lsxl_ge00_data);
-	kirkwood_ge01_init(&lsxl_ge01_data);
-
 	/* register power-off method */
 	pm_power_off = lsxl_power_off;
 }
diff --git a/arch/arm/mach-kirkwood/board-mplcec4.c b/arch/arm/mach-kirkwood/board-mplcec4.c
index 7d6dc66..a337ef5 100644
--- a/arch/arm/mach-kirkwood/board-mplcec4.c
+++ b/arch/arm/mach-kirkwood/board-mplcec4.c
@@ -11,24 +11,13 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mv643xx_eth.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data mplcec4_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
-};
-
-static struct mv643xx_eth_platform_data mplcec4_ge01_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(2),
-};
-
 void __init mplcec4_init(void)
 {
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
-	kirkwood_ge00_init(&mplcec4_ge00_data);
-	kirkwood_ge01_init(&mplcec4_ge01_data);
 	kirkwood_pcie_init(KW_PCIE0);
 }
 
diff --git a/arch/arm/mach-kirkwood/board-ns2.c b/arch/arm/mach-kirkwood/board-ns2.c
index f8f6605..ba3abd6 100644
--- a/arch/arm/mach-kirkwood/board-ns2.c
+++ b/arch/arm/mach-kirkwood/board-ns2.c
@@ -14,22 +14,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mv643xx_eth.h>
 #include <linux/of.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data ns2_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
 void __init ns2_init(void)
 {
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	if (of_machine_is_compatible("lacie,cloudbox") ||
-	    of_machine_is_compatible("lacie,netspace_lite_v2") ||
-	    of_machine_is_compatible("lacie,netspace_mini_v2"))
-		ns2_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
-	kirkwood_ge00_init(&ns2_ge00_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-openblocks_a6.c b/arch/arm/mach-kirkwood/board-openblocks_a6.c
index b11d8fd..120dccf 100644
--- a/arch/arm/mach-kirkwood/board-openblocks_a6.c
+++ b/arch/arm/mach-kirkwood/board-openblocks_a6.c
@@ -10,17 +10,8 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mv643xx_eth.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data openblocks_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
 void __init openblocks_a6_init(void)
 {
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_ge00_init(&openblocks_ge00_data);
 }
diff --git a/arch/arm/mach-kirkwood/board-readynas.c b/arch/arm/mach-kirkwood/board-readynas.c
index fb42c20..3ab3e0e 100644
--- a/arch/arm/mach-kirkwood/board-readynas.c
+++ b/arch/arm/mach-kirkwood/board-readynas.c
@@ -13,16 +13,10 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mv643xx_eth.h>
 #include <mach/kirkwood.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data netgear_readynas_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
 void __init netgear_readynas_init(void)
 {
-	kirkwood_ge00_init(&netgear_readynas_ge00_data);
 	kirkwood_pcie_init(KW_PCIE0);
 }
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
index acb0187..854d448 100644
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -18,27 +18,14 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mv643xx_eth.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include "common.h"
 #include "tsx1x-common.h"
 
-static struct mv643xx_eth_platform_data qnap_ts219_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
 void __init qnap_dt_ts219_init(void)
 {
-	u32 dev, rev;
-
-	kirkwood_pcie_id(&dev, &rev);
-	if (dev == MV88F6282_DEV_ID)
-		qnap_ts219_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
-
-	kirkwood_ge00_init(&qnap_ts219_ge00_data);
-
 	pm_power_off = qnap_tsx1x_power_off;
 }
 
diff --git a/arch/arm/mach-kirkwood/board-usi_topkick.c b/arch/arm/mach-kirkwood/board-usi_topkick.c
index 1cc04ec..44a8a6b 100644
--- a/arch/arm/mach-kirkwood/board-usi_topkick.c
+++ b/arch/arm/mach-kirkwood/board-usi_topkick.c
@@ -12,18 +12,9 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include "common.h"
 
-static struct mv643xx_eth_platform_data topkick_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
-};
-
 void __init usi_topkick_init(void)
 {
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_ge00_init(&topkick_ge00_data);
 }
-- 
1.7.2.5
