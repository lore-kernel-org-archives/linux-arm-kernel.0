From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 11:44:36 -0700
Subject: [PATCH] ARM: sunxi: Enable GMAC in sunxi_defconfig
Message-ID: <1398710676-9307-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the support of the GMAC has been merged, we're using it as the ethernet
controller on the A20 devices.

However, sunxi_defconfig wasn't selecting it hence breaking the NFS boot.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sunxi_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index b5df4a511b0a..81ba78eaf54a 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -37,7 +37,7 @@ CONFIG_SUN4I_EMAC=y
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SMSC is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
+CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
 CONFIG_SERIAL_8250=y
-- 
1.9.1
