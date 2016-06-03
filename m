From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  3 Jun 2016 15:38:15 -0700
Subject: [PATCH] arm64: defconfig: enable stmmac and realtek PHY as modules
Message-ID: <1464993495-19018-1-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Amlogic GXBB boards use the stmmac ethernet driver.  Also, enable
the realtek PHY used on meson-gxbb-odroidc2.  The micrel PHY used on the
meson-gxbb-p20x boards is already enabled.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d0491e..987a6158c19d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -127,6 +127,8 @@ CONFIG_SKY2=y
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
+CONFIG_STMMAC_ETH=m
+CONFIG_REALTEK_PHY=m
 CONFIG_MICREL_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
-- 
2.7.4
