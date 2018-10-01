From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon,  1 Oct 2018 17:10:45 +0900
Subject: [PATCH] arm64: defconfig: Enable USB phys for UniPhier SoCs
Message-ID: <1538381445-9222-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the USB3 and USB2 phys implemented in UniPhier SoCs.
These phys are necessary for dwc3 and ehci controllers driving
the USB ports on arm64 UniPhier SoCs.

Since the USB host drivers are already built-in, so only the phy
driver are missing to allow booting with USB devices.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..7298a4b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -592,6 +592,8 @@ CONFIG_PHY_ROCKCHIP_EMMC=y
 CONFIG_PHY_ROCKCHIP_PCIE=m
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
+CONFIG_PHY_UNIPHIER_USB3=y
+CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
 CONFIG_MESON_EFUSE=m
-- 
2.7.4
