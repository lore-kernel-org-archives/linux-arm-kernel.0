From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:29:51 +0200
Subject: [PATCH 0/4] gpio: lpc32xx: add new LPC32xx GPIO controller driver
Message-ID: <1447982995-30231-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changeset updates NXP LPC32xx GPIO controller driver on basis of
the new LPC32xx irqchip driver.

Unfortunately the old driver has too many hacks inherited from the
ancient legacy NXP BSP and I find it can not be maintained, the new
driver has compatible interface to device tree clients, so moving
to the new driver should not impact any GPIO consumers.

The changeset has dependencies on the recent updates to LPC32xx DTS:
 * http://permalink.gmane.org/gmane.linux.ports.arm.kernel/456304
 * Recent LPC32xx CCF series (no link at the moment)
 * Recent LPC32xx irqchip series (no link at the moment)

Vladimir Zapolskiy (4):
  dt-bindings: gpio: update desription of LPC32xx GPIO controller
  arm: dts: lpc32xx: extend description of gpio controller node
  gpio: lpc32xx: remove legacy LPC32xx GPIO driver
  gpio: lpc32xx: add new LPC32xx GPIO controller driver

 .../devicetree/bindings/gpio/gpio_lpc32xx.txt      | 121 ++-
 arch/arm/boot/dts/lpc32xx.dtsi                     |  85 +-
 drivers/gpio/Kconfig                               |   8 +
 drivers/gpio/Makefile                              |   2 +-
 drivers/gpio/gpio-lpc32xx.c                        | 961 +++++++++++----------
 5 files changed, 735 insertions(+), 442 deletions(-)

-- 
2.1.4
