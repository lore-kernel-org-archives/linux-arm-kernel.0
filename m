From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Apr 2015 21:48:40 +0200
Subject: [PATCH] ARM: sunxi: Enable simplefb in the defconfig
Message-ID: <1429559320-27519-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have simplefb support, we can enable it in our defconfig. Also
enable the framebuffer console, so that we are sure that we actually get
something displayed in any case.

And while we're at it, enable the module support.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sunxi_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 2c7af0a57cb1..7ebc346bf9fa 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -2,6 +2,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PERF_EVENTS=y
+CONFIG_MODULES=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
@@ -86,6 +87,10 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_FB=y
+CONFIG_FB_SIMPLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
-- 
2.3.5
