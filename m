From: y@lunn.ch (y at lunn.ch)
Date: Wed, 23 Oct 2013 16:12:50 +0200
Subject: [PATCH 1/3] ARM: Orion: Add missing includes
In-Reply-To: <y>
References: <y>
Message-ID: <1382537572-31472-1-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Building with C=1 generates warnings because of missing includes and
static keywords. Add them.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/plat-orion/common.c | 9 +++++----
 arch/arm/plat-orion/time.c   | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index c66d163..830ff07 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -22,6 +22,7 @@
 #include <linux/platform_data/dma-mv_xor.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <mach/bridge-regs.h>
+#include <plat/common.h>
 
 /* Create a clkdev entry for a given device/clk */
 void __init orion_clkdev_add(const char *con_id, const char *dev_id,
@@ -256,7 +257,7 @@ static __init void ge_complete(
 /*****************************************************************************
  * GE00
  ****************************************************************************/
-struct mv643xx_eth_shared_platform_data orion_ge00_shared_data;
+static struct mv643xx_eth_shared_platform_data orion_ge00_shared_data;
 
 static struct resource orion_ge00_shared_resources[] = {
 	{
@@ -322,7 +323,7 @@ void __init orion_ge00_init(struct mv643xx_eth_platform_data *eth_data,
 /*****************************************************************************
  * GE01
  ****************************************************************************/
-struct mv643xx_eth_shared_platform_data orion_ge01_shared_data;
+static struct mv643xx_eth_shared_platform_data orion_ge01_shared_data;
 
 static struct resource orion_ge01_shared_resources[] = {
 	{
@@ -373,7 +374,7 @@ void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
 /*****************************************************************************
  * GE10
  ****************************************************************************/
-struct mv643xx_eth_shared_platform_data orion_ge10_shared_data;
+static struct mv643xx_eth_shared_platform_data orion_ge10_shared_data;
 
 static struct resource orion_ge10_shared_resources[] = {
 	{
@@ -422,7 +423,7 @@ void __init orion_ge10_init(struct mv643xx_eth_platform_data *eth_data,
 /*****************************************************************************
  * GE11
  ****************************************************************************/
-struct mv643xx_eth_shared_platform_data orion_ge11_shared_data;
+static struct mv643xx_eth_shared_platform_data orion_ge11_shared_data;
 
 static struct resource orion_ge11_shared_resources[] = {
 	{
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 9d2b2ac..097d176 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/sched_clock.h>
+#include <plat/time.h>
 
 /*
  * MBus bridge block registers.
-- 
1.8.4.rc3
