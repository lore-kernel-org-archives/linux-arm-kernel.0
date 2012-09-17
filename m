From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 17 Sep 2012 18:38:56 +0100
Subject: [PATCH v5 10/17] xen/arm: introduce CONFIG_XEN on ARM
In-Reply-To: <alpine.DEB.2.02.1209171215490.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209171215490.29232@kaball.uk.xensource.com>
Message-ID: <1347903543-2135-10-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v5:

- make XEN_DOM0 depend on XEN;
- avoid "select XEN_DOM0" in XEN.


Changes in v2:

- mark Xen guest support on ARM as EXPERIMENTAL.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: Sergei Shtylyov <sshtylyov@mvista.com>
---
 arch/arm/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f88d8d..3361466 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1897,6 +1897,16 @@ config DEPRECATED_PARAM_STRUCT
 	  This was deprecated in 2001 and announced to live on for 5 years.
 	  Some old boot loaders still use this way.
 
+config XEN_DOM0
+	def_bool y
+	depends on XEN
+
+config XEN
+	bool "Xen guest support on ARM (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && ARM && OF
+	help
+	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
+
 endmenu
 
 menu "Boot options"
-- 
1.7.2.5
