From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 6 Aug 2012 15:27:15 +0100
Subject: [PATCH v2 12/23] xen/arm: introduce CONFIG_XEN on ARM
In-Reply-To: <alpine.DEB.2.02.1208061428060.4645@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1208061428060.4645@kaball.uk.xensource.com>
Message-ID: <1344263246-28036-12-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:

- mark Xen guest support on ARM as EXPERIMENTAL.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..f14664b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1855,6 +1855,16 @@ config DEPRECATED_PARAM_STRUCT
 	  This was deprecated in 2001 and announced to live on for 5 years.
 	  Some old boot loaders still use this way.
 
+config XEN_DOM0
+	def_bool y
+
+config XEN
+	bool "Xen guest support on ARM (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && ARM && OF
+	select XEN_DOM0
+	help
+	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
+
 endmenu
 
 menu "Boot options"
-- 
1.7.2.5
