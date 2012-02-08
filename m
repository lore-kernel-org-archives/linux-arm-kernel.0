From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed,  8 Feb 2012 12:13:27 +0200
Subject: [PATCH 2/2] arm: orion5x: print mac address with %pM
In-Reply-To: <1328696007-27538-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1328696007-27538-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <1328696007-27538-2-git-send-email-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/mach-orion5x/dns323-setup.c |    7 +++----
 arch/arm/mach-orion5x/tsx09-common.c |    4 +---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 9eec294..9e12ef8 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -201,9 +201,8 @@ static int __init dns323_read_mac_addr(void)
 	}
 
 	iounmap(mac_page);
-	printk("DNS-323: Found ethernet MAC address: ");
-	for (i = 0; i < 6; i++)
-		printk("%.2x%s", addr[i], (i < 5) ? ":" : ".\n");
+
+	pr_info("DNS-323: Found ethernet MAC address: %pM.\n", addr);
 
 	memcpy(dns323_eth_data.mac_addr, addr, 6);
 
@@ -637,7 +636,7 @@ static void __init dns323_init(void)
 	 * Configure peripherals.
 	 */
 	if (dns323_read_mac_addr() < 0)
-		printk("DNS-323: Failed to read MAC address\n");
+		pr_warning("DNS-323: Failed to read MAC address\n");
 	orion5x_ehci0_init();
 	orion5x_eth_init(&dns323_eth_data);
 	orion5x_i2c_init();
diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion5x/tsx09-common.c
index e65b528f..c2d813c 100644
--- a/arch/arm/mach-orion5x/tsx09-common.c
+++ b/arch/arm/mach-orion5x/tsx09-common.c
@@ -71,9 +71,7 @@ static int __init qnap_tsx09_check_mac_addr(const char *addr_str)
 			return -1;
 	}
 
-	printk(KERN_INFO "tsx09: found ethernet mac address ");
-	for (i = 0; i < 6; i++)
-		printk("%.2x%s", addr[i], (i < 5) ? ":" : ".\n");
+	pr_info("tsx09: found ethernet mac address %pM.\n", addr);
 
 	memcpy(qnap_tsx09_eth_data.mac_addr, addr, 6);
 
-- 
1.7.9
