From: alan@signal11.us (Alan Ott)
Date: Thu,  1 Mar 2012 14:26:48 -0500
Subject: [PATCH 6/8] ARM: tegra: USB_ULPI needs USB
In-Reply-To: <1330630010-11241-1-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
Message-ID: <1330630010-11241-7-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The USB_ULPI driver is selected by tegra, but can only be
built if at least one of USB or USB_GADGET is enabled.
The kernel fails to link if both are off.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-tegra/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index b2a038e..7ac3011 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -10,6 +10,7 @@ config ARCH_TEGRA_2x_SOC
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB_SUPPORT
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
+	select USB_GADGET if USB_SUPPORT && !USB
 	select CPU_FREQ_TABLE if CPU_FREQ
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
-- 
1.7.0.4
