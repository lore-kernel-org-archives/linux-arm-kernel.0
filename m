From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 29 Sep 2011 18:14:00 +0300
Subject: [PATCH 2/2] arm: orion5x: print mac address with %pM
In-Reply-To: <05721ba890447cd2f40d24bd70b133fe8750b969.1317309052.git.andriy.shevchenko@linux.intel.com>
References: <05721ba890447cd2f40d24bd70b133fe8750b969.1317309052.git.andriy.shevchenko@linux.intel.com>
Message-ID: <c7d9af28cdf5834ed8a7f0dcbd064a7fa9bbaabc.1317309052.git.andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-orion5x/dns323-setup.c |    5 ++---
 arch/arm/mach-orion5x/tsx09-common.c |    4 +---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index c95166e..09b8ed2 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -201,9 +201,8 @@ static int __init dns323_read_mac_addr(void)
 	}
 
 	iounmap(mac_page);
-	printk("DNS-323: Found ethernet MAC address: ");
-	for (i = 0; i < 6; i++)
-		printk("%.2x%s", addr[i], (i < 5) ? ":" : ".\n");
+
+	printk("DNS-323: Found ethernet MAC address: %pM.\n", addr);
 
 	memcpy(dns323_eth_data.mac_addr, addr, 6);
 
diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion5x/tsx09-common.c
index e65b528f..c1aef01 100644
--- a/arch/arm/mach-orion5x/tsx09-common.c
+++ b/arch/arm/mach-orion5x/tsx09-common.c
@@ -71,9 +71,7 @@ static int __init qnap_tsx09_check_mac_addr(const char *addr_str)
 			return -1;
 	}
 
-	printk(KERN_INFO "tsx09: found ethernet mac address ");
-	for (i = 0; i < 6; i++)
-		printk("%.2x%s", addr[i], (i < 5) ? ":" : ".\n");
+	printk(KERN_INFO "tsx09: found ethernet mac address %pM.\n", addr);
 
 	memcpy(qnap_tsx09_eth_data.mac_addr, addr, 6);
 
-- 
1.7.6.3
