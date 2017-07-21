From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Jul 2017 18:20:04 +0200
Subject: [PATCH 3/4] arm: sunxi: Add AXP20X_ADC
In-Reply-To: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
References: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
Message-ID: <20170721162005.18892-3-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APX20X_POWER option, that is a dependency of the USB controllers
depends on IIO and AXP20X_ADC. Add it so that we can get a working USB
back.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sunxi_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 400eb9366a66..456988dd7b0e 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -127,6 +127,8 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXTCON=y
+CONFIG_IIO=y
+CONFIG_AXP20X_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_SUN4I=y
 CONFIG_PHY_SUN4I_USB=y
-- 
2.13.3
