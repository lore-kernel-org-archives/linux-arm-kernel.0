From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Oct 2014 23:29:09 -0700
Subject: [PATCH] ARM: sunxi_defconfig: enable CONFIG_REGULATOR
Message-ID: <1413354549-9012-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 97a13e5289ba ('net: phy: mdio-sun4i: don't select REGULATOR') removed
the select of REGULATOR, which means that it now has to be explicitly
enabled in the defconfig or things won't work very well.

In particular, this fixes a problem with SD/MMC not probing on my A31-based
board.

Cc: Beniamino Galvani <b.galvani@gmail.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---

Maxime, I'll apply this on our fixes branch directly.

 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index c1a4ca4f6e6d..847045313101 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -75,6 +75,7 @@ CONFIG_POWER_RESET_SUN6I=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AXP20X=y
+CONFIG_REGULATOR=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.0.1.473.gc4d58ca
