From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:00 +0000
Subject: [PATCH 01/19] ARM: shmobile: fix defconfig warning on CONFIG_USB
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent update to the marzen_defconfig introduced a
duplicate CONFIG_USB=y line. This removes one of the
two.

arch/arm/configs/marzen_defconfig:86:warning: override: reassigning to symbol USB

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: linux-sh at vger.kernel.org
---
 arch/arm/configs/marzen_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 728a43c..afb17d6 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -83,7 +83,6 @@ CONFIG_USB=y
 CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
-CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
-- 
1.8.0
