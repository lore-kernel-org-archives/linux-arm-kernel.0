From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Mar 2011 20:22:17 +0900
Subject: [PATCH] ARM: Suspend: Fix dependency of ARCH_SUSPEND_POSSIBLE
Message-ID: <1301052137-13788-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current mainline codes of ARCH_S5P64X0 and ARCH_S5P6442
can not support suspend to ram. So needs this for preventing
build error on them.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
As a note, suspend to ram will be supported on them soon :)

 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 93d595a..efe06e0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2009,6 +2009,7 @@ menu "Power management options"
 source "kernel/power/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
+	depends on !ARCH_S5P64X0 && !ARCH_S5P6442
 	def_bool y
 
 endmenu
-- 
1.7.1
