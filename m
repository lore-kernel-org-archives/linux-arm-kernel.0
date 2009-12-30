From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 30 Dec 2009 11:35:21 -0500
Subject: [PATCH] ep93xx: use pr_fmt in clock.c
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F61D@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pr_fmt to prefix kernel output with the module name and change
all printk messages to pr_<level> format.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 1d0f9d8..07a58d0 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -10,6 +10,8 @@
  * your option) any later version.
  */
 
+#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -468,9 +470,9 @@ static int __init ep93xx_clock_init(void)
 	}
 	clk_usb_host.rate = clk_pll2.rate / (((value >> 28) & 0xf) + 1);
 
-	printk(KERN_INFO "ep93xx: PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
+	pr_info("PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
 		clk_pll1.rate / 1000000, clk_pll2.rate / 1000000);
-	printk(KERN_INFO "ep93xx: FCLK %ld MHz, HCLK %ld MHz, PCLK %ld MHz\n",
+	pr_info("FCLK %ld MHz, HCLK %ld MHz, PCLK %ld MHz\n",
 		clk_f.rate / 1000000, clk_h.rate / 1000000,
 		clk_p.rate / 1000000);
  
