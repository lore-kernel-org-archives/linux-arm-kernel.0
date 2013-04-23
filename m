From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:45 +0200
Subject: [PATCH 13/21] misc: mark spear13xx-pcie-gadget as broken
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-14-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver was merged in 2.6.38 but never actually compiled because
it depends on the <mach/pcie.h> header that has not made it into the
kernel. Starting with Linux-3.10, this results in "allyesconfig"
build errors, since spear13xx can now be enabled with the default
"multiplatform" platform on ARM. Let's mark it as broken for now.
If it doesn't get fixed, we can drop it completely.

Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e83fdfe..c74b13b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -398,7 +398,7 @@ config DS1682
 
 config SPEAR13XX_PCIE_GADGET
 	bool "PCIe gadget support for SPEAr13XX platform"
-	depends on ARCH_SPEAR13XX
+	depends on ARCH_SPEAR13XX && BROKEN
 	default n
 	help
 	 This option enables gadget support for PCIe controller. If
-- 
1.8.1.2
