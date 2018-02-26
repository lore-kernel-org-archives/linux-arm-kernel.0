From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 26 Feb 2018 09:51:41 -0600
Subject: [PATCH] arm64: defconfig: enable stmmac ethernet to defconfig
Message-ID: <1519660301-18389-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the CONFIG_STMMAC_ETH to the default arm64 defconfig:

-CONFIG_STMMAC_ETH=m
+CONFIG_STMMAC_ETH=y
+CONFIG_DWMAC_IPQ806X=m
+CONFIG_DWMAC_MESON=m
+CONFIG_DWMAC_ROCKCHIP=m
+CONFIG_DWMAC_SUNXI=m
+CONFIG_DWMAC_SUN8I=m

The STMMAC ethernet controller is on the Stratix10 platform, and thus needs
driver to be in the kernel image for NFS to work.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/configs/defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..a3ea32e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -209,7 +209,12 @@ CONFIG_QCOM_EMAC=m
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
-CONFIG_STMMAC_ETH=m
+CONFIG_STMMAC_ETH=y
+CONFIG_DWMAC_IPQ806X=m
+CONFIG_DWMAC_MESON=m
+CONFIG_DWMAC_ROCKCHIP=m
+CONFIG_DWMAC_SUNXI=m
+CONFIG_DWMAC_SUN8I=m
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_AT803X_PHY=m
 CONFIG_MARVELL_PHY=m
-- 
2.7.4
