From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Fri, 20 Nov 2015 02:46:18 +0100
Subject: [PATCH v2 2/3] ARM: sunxi: Really enable LRADC keys in sunxi_defconfig
In-Reply-To: <1447983979-12751-1-git-send-email-public_timo.s@silentcreek.de>
References: <1447724578-4786-1-git-send-email-public_timo.s@silentcreek.de>
 <1447983979-12751-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <1447983979-12751-2-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit be8becb81bdc ("ARM: sunxi_defconfig: Enable LRADC keys
(KEYBOARD_SUN4I_LRADC)") added CONFIG_KEYBOARD_SUN4I_LRADC=y to
sunxi_defconfig. However, it depends on CONFIG_KEYBOARD which is
explicitly disabled in sunxi_defconfig. Hence, the LRADC keys were
never actually enabled. Remove the line disabling CONFIG_KEYBOARD in
order to really enable KEYBOARD_SUN4I_LRADC.

Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
---
 arch/arm/configs/sunxi_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 0bbc2ee..90252ca 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -60,7 +60,6 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_AXP20X_PEK=y
-- 
2.1.4
