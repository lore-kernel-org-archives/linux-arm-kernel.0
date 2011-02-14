From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 14 Feb 2011 15:33:15 +0300
Subject: [PATCH 0/5][RESENT] Get rid of gpio-vbus related code from pxa25x_udc
Message-ID: <1297686800-27599-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently pxa25x_udc contains some code duplicating gpio-vbus functionality.
Please merge this serie of patches (based on v2.6.38-rc4), which makes all
relevant platforms use gpio-vbus tranceiver instead of relying on pxa25x_udc
and then drop support for gpio-vbus handling in pxa25x_udc.

Please tell me if I should rebase these patches on top of some other commit.

The following changes since commit 100b33c8bd8a3235fd0b7948338d6cbb3db3c63d:

  Linux 2.6.38-rc4 (2011-02-07 16:03:55 -0800)

Dmitry Eremin-Solenikov (5):
      eseries: switch to using gpio-vbus transceiver
      gumstix: switch to using gpio-vbus transceiver
      tosa: switch to using gpio-vbus transceiver
      pxa25x_udc: stop handling gpio-vbus internally
      pxa2xx: drop gpio_vbus field from info struct

 arch/arm/include/asm/mach/udc_pxa2xx.h |    2 -
 arch/arm/mach-pxa/corgi.c              |    1 -
 arch/arm/mach-pxa/devices.c            |    1 -
 arch/arm/mach-pxa/eseries.c            |   34 +++++++++++---
 arch/arm/mach-pxa/gumstix.c            |   13 +++++-
 arch/arm/mach-pxa/tosa.c               |   13 +++++-
 drivers/usb/gadget/pxa25x_udc.c        |   76 +++-----------------------------
 7 files changed, 55 insertions(+), 85 deletions(-)
