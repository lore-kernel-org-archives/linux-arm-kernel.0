From: alan@signal11.us (Alan Ott)
Date: Fri,  2 Mar 2012 17:26:00 -0500
Subject: [PATCH v3 4/5] ARM: tegra: select USB_ULPI if USB is selected
In-Reply-To: <1330727075-10974-1-git-send-email-alan@signal11.us>
References: <1330727075-10974-1-git-send-email-alan@signal11.us>
Message-ID: <1330727160-11242-1-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Automatically select USB_ULPI if USB is enabled on Tegra.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alan Ott <alan@signal11.us>
---
 arch/arm/mach-tegra/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 60f3e4b..fdef6b2 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -8,7 +8,7 @@ config ARCH_TEGRA_2x_SOC
 	select ARM_GIC
 	select ARCH_REQUIRE_GPIOLIB
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
-	select USB_ULPI if USB_SUPPORT
+	select USB_ULPI if USB
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
 	select CPU_FREQ_TABLE if CPU_FREQ
 	help
@@ -21,7 +21,7 @@ config ARCH_TEGRA_3x_SOC
 	select ARM_GIC
 	select ARCH_REQUIRE_GPIOLIB
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
-	select USB_ULPI if USB_SUPPORT
+	select USB_ULPI if USB
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
 	select USE_OF
 	select CPU_FREQ_TABLE if CPU_FREQ
-- 
1.7.0.4
