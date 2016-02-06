From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Feb 2016 23:53:47 +0800
Subject: [PATCH 4/6] ARM: sunxi_defconfig: Enable INPUT_EVDEV so axp20x-pek
 can be used
In-Reply-To: <1454774029-10469-1-git-send-email-wens@csie.org>
References: <1454774029-10469-1-git-send-email-wens@csie.org>
Message-ID: <1454774029-10469-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi_defconfig already enables INPUT_AXP20X_PEK, but the device is not
exposed to userspace. Enable INPUT_EVDEV so it is.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index e29b81694184..a3a27e830ef9 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -58,6 +58,7 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_SUN4I_LRADC=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
-- 
2.7.0
