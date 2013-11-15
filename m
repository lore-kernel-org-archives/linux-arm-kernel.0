From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:01 -0700
Subject: [PATCH 06/31] ARM: tegra: select the reset framework
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-7-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra clock driver is built unconditionally when Tegra support is
enabled. In order to avoid having to ifdef the forthcoming reset driver
implementation, have ARCH_TEGRA select RESET_CONTROLLER.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 09e740f58b27..15c09294effa 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -14,6 +14,8 @@ config ARCH_TEGRA
 	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
 	select PINCTRL
+	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select SOC_BUS
 	select SPARSE_IRQ
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
-- 
1.8.1.5
