From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 17 Jun 2015 18:00:39 -0700
Subject: [PATCH v3 0/4] GPIO support for BRCMSTB
Message-ID: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds interrupt support for the GPIO controller (UPG GIO) used on Broadcom's
various BRCMSTB SoCs (BCM7XXX and others).  For all existing hardware, this
block hooks up to the BCM7120 L2 IRQ controller and so will require
CONFIG_BCM7120_L2_IRQ=y.

New in v3:
- fix a null pointer dereference noticed by Tim Ross
- use the gpiolib irqchip helpers as recommended by Linus Walleij
- update device tree bindings as suggested by Brian Norris:
  https://lkml.org/lkml/2015/5/29/802
- add S5 (cold boot) support

The following are not included in this patchset:
- Initial device tree bindings (merged from v1 to GPIO tree)
- Initial GPIO support w/o interrupts (merged from v2 to GPIO tree)
- ARM Kconfig changes (merged from v2 to arm-soc tree)

Previous revisions:
v1: https://lkml.org/lkml/2015/5/6/199
v2: https://lkml.org/lkml/2015/5/28/853

Gregory Fong (4):
  gpio: brcmstb: fix null ptr dereference in driver remove
  dt-bindings: brcmstb-gpio: document properties for wakeup
  gpio: brcmstb: Add interrupt and wakeup source support
  gpio: brcmstb: support wakeup from S5 cold boot

 .../devicetree/bindings/gpio/brcm,brcmstb-gpio.txt |  35 ++-
 drivers/gpio/Kconfig                               |   1 +
 drivers/gpio/gpio-brcmstb.c                        | 321 ++++++++++++++++++++-
 3 files changed, 341 insertions(+), 16 deletions(-)

-- 
1.9.1
