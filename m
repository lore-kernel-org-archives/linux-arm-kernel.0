From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Dec 2017 12:56:38 +0100
Subject: [PATCH v2] MAINTAINERS: Add self as extended maintainer for a slew of
 files
Message-ID: <20171221115638.7850-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take over sole maintenance of Nomadik, U300 and Ux500. Since all are
Device Tree converted and using standard format drivers this is not
burdensome. Alessandro is not working on this platform any more.
Let's use one single git tree for all of them and combine the
MAINTAINERS entries into one.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Combine the existing U300 and Ux500 entries into this entry
  covering all ST-Ericsson/Nomadik families.
- Add Alessandro's ACK.

ARM SoC folks: please apply this directly where appropriate.
---
 MAINTAINERS | 63 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..0d6b84abad1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1634,14 +1634,38 @@ ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
 S:	Maintained
 
-ARM/NOMADIK ARCHITECTURE
-M:	Alessandro Rubini <rubini@unipv.it>
+ARM/NOMADIK/U300/Ux500 ARCHITECTURES
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-nomadik/
-F:	drivers/pinctrl/nomadik/
+F:	arch/arm/mach-u300/
+F:	arch/arm/mach-ux500/
+F:	arch/arm/boot/dts/ste-*
+F:	drivers/clk/clk-nomadik.c
+F:	drivers/clk/clk-u300.c
+F:	drivers/clocksource/clksrc-dbx500-prcmu.c
+F:	drivers/clocksource/timer-u300.c
+F:	drivers/dma/coh901318*
+F:	drivers/dma/ste_dma40*
+F:	drivers/hwspinlock/u8500_hsem.c
 F:	drivers/i2c/busses/i2c-nomadik.c
+F:	drivers/i2c/busses/i2c-stu300.c
+F:	drivers/mfd/ab3100*
+F:	drivers/mfd/ab8500*
+F:	drivers/mfd/abx500*
+F:	drivers/mfd/dbx500*
+F:	drivers/mfd/db8500*
+F:	drivers/pinctrl/nomadik/
+F:	drivers/pinctrl/pinctrl-coh901*
+F:	drivers/pinctrl/pinctrl-u300.c
+F:	drivers/rtc/rtc-ab3100.c
+F:	drivers/rtc/rtc-ab8500.c
+F:	drivers/rtc/rtc-coh901331.c
+F:	drivers/rtc/rtc-pl031.c
+F:	drivers/watchdog/coh901327_wdt.c
+F:	Documentation/devicetree/bindings/arm/ste-*
+F:	Documentation/devicetree/bindings/arm/ux500/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
 
 ARM/NUVOTON W90X900 ARM ARCHITECTURE
@@ -2021,21 +2045,6 @@ M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
 M:	Dirk Opfer <dirk@opfer-online.de>
 S:	Maintained
 
-ARM/U300 MACHINE SUPPORT
-M:	Linus Walleij <linus.walleij@linaro.org>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	arch/arm/mach-u300/
-F:	drivers/clocksource/timer-u300.c
-F:	drivers/i2c/busses/i2c-stu300.c
-F:	drivers/rtc/rtc-coh901331.c
-F:	drivers/watchdog/coh901327_wdt.c
-F:	drivers/dma/coh901318*
-F:	drivers/mfd/ab3100*
-F:	drivers/rtc/rtc-ab3100.c
-F:	drivers/rtc/rtc-coh901331.c
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
-
 ARM/UNIPHIER ARCHITECTURE
 M:	Masahiro Yamada <yamada.masahiro@socionext.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
@@ -2057,24 +2066,6 @@ F:	drivers/reset/reset-uniphier.c
 F:	drivers/tty/serial/8250/8250_uniphier.c
 N:	uniphier
 
-ARM/Ux500 ARM ARCHITECTURE
-M:	Linus Walleij <linus.walleij@linaro.org>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-ux500/
-F:	drivers/clocksource/clksrc-dbx500-prcmu.c
-F:	drivers/dma/ste_dma40*
-F:	drivers/hwspinlock/u8500_hsem.c
-F:	drivers/mfd/abx500*
-F:	drivers/mfd/ab8500*
-F:	drivers/mfd/dbx500*
-F:	drivers/mfd/db8500*
-F:	drivers/pinctrl/nomadik/pinctrl-ab*
-F:	drivers/pinctrl/nomadik/pinctrl-nomadik*
-F:	drivers/rtc/rtc-ab8500.c
-F:	drivers/rtc/rtc-pl031.c
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
-
 ARM/Ux500 CLOCK FRAMEWORK SUPPORT
 M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.14.3
