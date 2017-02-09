From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Feb 2017 17:39:21 +0100
Subject: [PATCH 7/8] ARM: sunxi: Select PM_OPP
In-Reply-To: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <e1424c55f3f8b1176f24a446936d189b00383a4c.1486655917.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device frequency scaling is implemented through devfreq in the kernel,
which requires CONFIG_PM_OPP.

Let's select it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+), 0 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b9863f9a35fa..58153cdf025b 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,6 +6,7 @@ menuconfig ARCH_SUNXI
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	select PINCTRL
+	select PM_OPP
 	select SUN4I_TIMER
 	select RESET_CONTROLLER
 
-- 
git-series 0.8.11
