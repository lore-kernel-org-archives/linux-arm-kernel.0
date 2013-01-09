From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  9 Jan 2013 15:36:02 +0100
Subject: [PATCH] ARM: mxs: select USB_ARCH_HAS_EHCI
Message-ID: <1357742162-27982-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 09f6ffde introduced a dependency on USB_EHCI_HCD for the chipidea
USB host driver, that in turns depends on USB_ARCH_HAS_EHCI.

If this symbol is not selected by the ARCH, we are not able to use the
chipidea driver anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f95ba14..c77d1d1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -456,6 +456,7 @@ config ARCH_MXS
 	select PINCTRL
 	select SPARSE_IRQ
 	select USE_OF
+	select USB_ARCH_HAS_EHCI
 	help
 	  Support for Freescale MXS-based family of processors
 
-- 
1.7.10.4
