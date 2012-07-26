From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Jul 2012 16:33:53 +0100
Subject: [PATCH 11/24] xen/arm: introduce CONFIG_XEN on ARM
In-Reply-To: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
Message-ID: <1343316846-25860-11-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..9c54cb4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2228,6 +2228,16 @@ config NEON
 	  Say Y to include support code for NEON, the ARMv7 Advanced SIMD
 	  Extension.
 
+config XEN_DOM0
+	def_bool y
+
+config XEN
+	bool "Xen guest support on ARM"
+	depends on ARM && OF
+	select XEN_DOM0
+	help
+	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
+
 endmenu
 
 menu "Userspace binary formats"
-- 
1.7.2.5
