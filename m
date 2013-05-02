From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 17:16:22 +0200
Subject: [PATCH, RFC 18/22] Xen: SWIOTLB is only used on x86
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Message-ID: <1367507786-505303-19-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling SWIOTLB_XEN on ARM results in build errors because the
underlying SWIOTLB is only available on X86:

drivers/xen/swiotlb-xen.c: In function 'is_xen_swiotlb_buffer':
drivers/xen/swiotlb-xen.c:105:2: error: implicit declaration of function 'mfn_to_local_pfn

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index dd4d9cb..f03bf50 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -141,7 +141,7 @@ config XEN_GRANT_DEV_ALLOC
 
 config SWIOTLB_XEN
 	def_bool y
-	depends on PCI
+	depends on PCI && X86
 	select SWIOTLB
 
 config XEN_TMEM
-- 
1.8.1.2
