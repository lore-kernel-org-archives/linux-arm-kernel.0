From: tony@atomide.com (Tony Lindgren)
Date: Thu,  8 Nov 2018 08:52:21 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: Enable 8250-omap serial driver and
 use it by default
Message-ID: <20181108165221.22775-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've already moved omap2plus_defconfig over to use 8250-omap instead of
omap-serial driver. Let's update multi_v7_defconfig too.

By default we also enable SERIAL_8250_OMAP_TTYO_FIXUP that updates the
kernel serial console to point to 8250 driver and warns about it during
the boot.

Users with ttyO[0123] in their /etc/inittab should update inittab to
to use ttyS[0123] instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -305,6 +305,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_BCM2835AUX=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_EM=y
+CONFIG_SERIAL_8250_OMAP=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_8250_UNIPHIER=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
2.19.1
