From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 23 Jul 2013 17:46:58 +0100
Subject: [PATCH] do not allow XEN_TMEM on ARM64
Message-ID: <alpine.DEB.2.02.1307231745520.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tmem is not supported on arm or arm64 yet.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 9e02d60..a18f350 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -145,7 +146,7 @@ config SWIOTLB_XEN
 
 config XEN_TMEM
 	tristate
-	depends on !ARM
+	depends on !ARM && !ARM64
 	default m if (CLEANCACHE || FRONTSWAP)
 	help
 	  Shim to interface in-kernel Transcendent Memory hooks
