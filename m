From: denis@eukrea.com (Denis Carikli)
Date: Thu,  9 Jan 2014 18:15:14 +0100
Subject: [PATCHv9][ 1/3] ARM i.MX35: build in pinctrl support.
Message-ID: <1389287716-12802-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v8->v9:
- patch refreshed when applying it.

ChangeLog v7->v8:
- The addition of the imx35 pinctrl driver selection in Kconfig that was in the
  patch adding the devicetree support for the imx35 was moved here.
---
 arch/arm/mach-imx/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index b0c6eb3..2586eab 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -125,6 +125,8 @@ config SOC_IMX35
 	select CPU_V6K
 	select HAVE_EPIT
 	select MXC_AVIC
+	select PINCTRL
+	select PINCTRL_IMX35
 	select SMP_ON_UP if SMP
 	select PINCTRL
 
-- 
1.7.9.5
