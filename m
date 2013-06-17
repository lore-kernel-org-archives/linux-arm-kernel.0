From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:34:03 +0200
Subject: [PATCH v2 18/38] USB: Check for ARCH_EXYNOS separately
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-19-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_EXYNOS is going to be excluded from PLAT_S5P, so it must be checked
separately in Exynos-related Kconfig entries.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/Kconfig      | 1 +
 drivers/usb/host/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 92e1dc9..a3b48b5 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -43,6 +43,7 @@ config USB_ARCH_HAS_EHCI
 	default y if ARCH_VT8500
 	default y if PLAT_SPEAR
 	default y if PLAT_S5P
+	default y if ARCH_EXYNOS
 	default y if ARCH_MSM
 	default y if MICROBLAZE
 	default y if SPARC_LEON
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 344d5e2..922a65d 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -225,7 +225,7 @@ config USB_EHCI_SH
 
 config USB_EHCI_S5P
        tristate "EHCI support for Samsung S5P/EXYNOS SoC Series"
-       depends on PLAT_S5P
+       depends on PLAT_S5P || ARCH_EXYNOS
        help
 	Enable support for the Samsung S5Pxxxx and Exynos3/4/5 SOC's
 	on-chip EHCI controller.
-- 
1.8.2.1
