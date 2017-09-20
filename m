From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Wed, 20 Sep 2017 13:14:07 +0200
Subject: [PATCH V2 7/8] MIPS: BCM63XX: provide enet clocks as "enet" to the
 ethernet devices
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Message-ID: <20170920111408.29711-8-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add lookups to provide the appropriate enetX clocks as just "enet" to
the ethernet devices.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index ba5758551c94..2018425fe97e 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -377,6 +377,8 @@ static struct clk_lookup bcm3368_clks[] = {
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
 	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet0),
+	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet1),
 };
 
 static struct clk_lookup bcm6328_clks[] = {
@@ -404,6 +406,7 @@ static struct clk_lookup bcm6338_clks[] = {
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet_misc),
 };
 
 static struct clk_lookup bcm6345_clks[] = {
@@ -417,6 +420,7 @@ static struct clk_lookup bcm6345_clks[] = {
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet_misc),
 };
 
 static struct clk_lookup bcm6348_clks[] = {
@@ -430,6 +434,8 @@ static struct clk_lookup bcm6348_clks[] = {
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet_misc),
+	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet_misc),
 };
 
 static struct clk_lookup bcm6358_clks[] = {
@@ -445,6 +451,8 @@ static struct clk_lookup bcm6358_clks[] = {
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
 	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet0),
+	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet1),
 };
 
 static struct clk_lookup bcm6362_clks[] = {
-- 
2.13.2
