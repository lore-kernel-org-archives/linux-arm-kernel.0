From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Oct 2009 17:13:41 -0700
Subject: [PATCH 1/6] omap: Fix Unlikely(x) < y
In-Reply-To: <20091014001233.6116.84749.stgit@localhost>
References: <20091014001233.6116.84749.stgit@localhost>
Message-ID: <20091014001341.6116.47622.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roel Kluin <roel.kluin@gmail.com>

The closing parenthesis was not on the right location.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 71ebd7f..7c345b7 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -373,7 +373,7 @@ static inline int gpio_valid(int gpio)
 
 static int check_gpio(int gpio)
 {
-	if (unlikely(gpio_valid(gpio)) < 0) {
+	if (unlikely(gpio_valid(gpio) < 0)) {
 		printk(KERN_ERR "omap-gpio: invalid GPIO %d\n", gpio);
 		dump_stack();
 		return -1;
