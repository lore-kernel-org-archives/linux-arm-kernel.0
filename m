From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 28 Jan 2016 16:33:52 +0000
Subject: [PATCH V5 14/14] ARM64: tegra: select PM_GENERIC_DOMAINS
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1453998832-27383-15-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that devices
dependent upon a particular power-domain are only probed when that power
domain has been powered up, requires that PM is made mandatory for tegra
64-bit devices and so select this option for tegra as well.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 8a0952275291..cdec2dfae3aa 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -102,6 +102,8 @@ config ARCH_TEGRA
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
 	select PINCTRL
+	select PM
+	select PM_GENERIC_DOMAINS
 	select RESET_CONTROLLER
 	help
 	  This enables support for the NVIDIA Tegra SoC family.
-- 
2.1.4
