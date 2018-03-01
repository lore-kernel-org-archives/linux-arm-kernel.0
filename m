From: tony@atomide.com (Tony Lindgren)
Date: Thu,  1 Mar 2018 14:17:04 -0800
Subject: [PATCH 10/10] ARM: omap2plus_defconfig: Enable 8250_OMAP
In-Reply-To: <20180301221704.104530-1-tony@atomide.com>
References: <20180301221704.104530-1-tony@atomide.com>
Message-ID: <20180301221704.104530-11-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've had 8250_OMAP working for few years now, so let's start enabling
it by default. We provide users an option to warn by default with
SERIAL_8250_OMAP_TTYO_FIXUP by default. That option updates the serial
console to point to 8250 driver and warns about it.

Users with ttyO[0123] in their /etc/inittab should update inittab
to use ttyS[0123] instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -246,6 +246,7 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_8250_OMAP=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_OMAP=y
 CONFIG_SERIAL_OMAP_CONSOLE=y
-- 
2.16.2
