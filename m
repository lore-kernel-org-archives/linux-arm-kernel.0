From: carlo@caione.org (Carlo Caione)
Date: Mon, 25 May 2015 13:00:39 +0200
Subject: [PATCH 0/2] pinctrl: Enable support for external GPIO interrupts
Message-ID: <1432551641-3256-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

In Meson SoCs we have 8 independent GPIO interrupts that can be programmed to
use any of the GPIOs in the chip as interrupt source.

These GPIOs are managed by GIC but they can be conditioned (and enabled) by
some registers external to the GIC.

GPIOs |--[mux1 or mux2]--[polarity]--[filter]--[edge_select]--> GIC

The original work has been done by Beniamino. I cleaned it up, fixed a couple
of bugs, added support for Meson8b and the fix for the .to_irq hook.

Beniamino Galvani (2):
  pinctrl: meson: Enable GPIO IRQs
  pinctrl: dt-binding: Extend meson documentation with GPIO IRQs support

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |  12 +
 drivers/pinctrl/Kconfig                            |   1 +
 drivers/pinctrl/meson/pinctrl-meson.c              | 254 +++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.h              |  18 +-
 drivers/pinctrl/meson/pinctrl-meson8.c             |  36 +--
 drivers/pinctrl/meson/pinctrl-meson8b.c            |  36 +--
 6 files changed, 326 insertions(+), 31 deletions(-)

-- 
1.9.1
