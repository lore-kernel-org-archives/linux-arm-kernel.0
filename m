From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 14 Aug 2015 16:36:11 +0800
Subject: [RFC PATCH v5 7/9] arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
In-Reply-To: <1439541232-30100-1-git-send-email-shawn.lin@rock-chips.com>
References: <1439541232-30100-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1439541371-30394-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DesignWare MMC Controller's transfer mode should be decided
at runtime instead of compile-time. So we remove this config
option and read dw_mmc's register to select DMA master.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Joachim Eastwood <manabian@gmail.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/configs/lpc18xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 1c47f86..b7e8cda 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -119,7 +119,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_PCA9532=y
-- 
2.3.7
