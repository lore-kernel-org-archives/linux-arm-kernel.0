From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 18 Dec 2010 21:39:26 +0800
Subject: [PATCH v7 00/15] ARM: mxs: Add initial support for MX23 and MX28
Message-ID: <1292679575-2635-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v7 of this patch series:
 - Use clocksource_register_hz
 - Add mxs namespace for the missing ones
 - Use CLKCTRL_RESET_CHIP over RTC_WATCHDOG to implement arch_reset
 - Define naked pad and introduce validity bits for mA/vol/pull
   to ease the pad modification
 - List all pad definitions at once generated from Freescale
   pinmux Excel sheet
 - Add more comments for timrot instance used for MX23 and MX28
 - Use HW_TIMROT_TIMCOUNTn for v1 to avoid confusion
 - Detect timrot version by reading register HW_TIMROT_VERSION
 - Switch over to use gpiolib __gpio_to_irq()
 - Fix some checkpatch warnings

The full change log could be found in the version history of
following individual patch.

 [PATCH v7 03/15] ARM: mxs: Add reset routines
 [PATCH v7 04/15] ARM: mxs: Add interrupt support
 [PATCH v7 05/15] ARM: mxs: Add low-level debug UART support
 [PATCH v7 06/15] ARM: mxs: Add timer support
 [PATCH v7 07/15] ARM: mxs: Add gpio support
 [PATCH v7 08/15] ARM: mxs: Add iomux support
 [PATCH v7 09/15] ARM: mxs: Add clock support
 [PATCH v7 13/15] ARM: mxs: Add initial mx23evk support
 [PATCH v7 14/15] ARM: mxs: Add initial mx28evk support

Thanks all for the review.

Regards,
Shawn
