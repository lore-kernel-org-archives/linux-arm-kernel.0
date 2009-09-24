From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Sep 2009 16:43:14 -0700
Subject: [PATCH 09/12] omap: Fix a OMAP_MPUIO_VBASE typo for 850
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Message-ID: <20090924234314.6065.39144.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Angelo Arrifano <miknix@gmail.com>

This was crashing omap850 devices.

Reported-by:
  Alistair Buxton <a.j.buxton@gmail.com>

Signed-off-by: Angelo Arrifano <miknix@gmail.com>
Signed-obb-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 693839c..71ebd7f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -250,7 +250,7 @@ static struct gpio_bank gpio_bank_730[7] = {
 
 #ifdef CONFIG_ARCH_OMAP850
 static struct gpio_bank gpio_bank_850[7] = {
-	{ OMAP1_MPUIO_BASE,     INT_850_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
+	{ OMAP1_MPUIO_VBASE,     INT_850_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
 	{ OMAP850_GPIO1_BASE,  INT_850_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_850 },
 	{ OMAP850_GPIO2_BASE,  INT_850_GPIO_BANK2,  IH_GPIO_BASE + 32,	METHOD_GPIO_850 },
 	{ OMAP850_GPIO3_BASE,  INT_850_GPIO_BANK3,  IH_GPIO_BASE + 64,	METHOD_GPIO_850 },
