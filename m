From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon,  1 Oct 2018 17:10:21 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: Enable USB phys for UniPhier SoCs
Message-ID: <1538381421-9171-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the USB3 and USB2 phys implemented in UniPhier SoCs.
These phys are necessary for dwc3 and ehci controllers driving
the USB ports on Pro4 and PXs2 SoCs.

Since the USB host drivers are already built-in, so only the phy
driver are missing to allow booting with USB devices.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e6b3c96..e52c685 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -977,6 +977,8 @@ CONFIG_PHY_SUN9I_USB=y
 CONFIG_PHY_SAMSUNG_USB2=m
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_BRCM_SATA=y
+CONFIG_PHY_UNIPHIER_USB3=y
+CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_NVMEM=y
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_SUNXI_SID=y
-- 
2.7.4
