From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 15 Jul 2012 15:16:18 +0200
Subject: [PULL] [PATCH 0/4] arm: at91: gpio fix
Message-ID: <20120715131618.GF4450@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	This patch series fix 2 issue on at91

	first the gpio are not mux to gpio shen requested and free

	second on the sam9x5 series we ma not have 32 pins routed on each bank

The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:

  Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-for-3.5-gpio-fix

for you to fetch changes up to 8b8d117749961ec387e7a3b1ecc29eb24c73ca9c:

  arm: at91: at91sam9x5: fix gpio number per bank (2012-07-15 20:46:06 +0800)

----------------------------------------------------------------
arm: at91: gpio fixes

This patch series fix 2 issue on at91

first the gpio are not mux to gpio shen requested and free

second on the sam9x5 series we ma not have 32 pins routed on each bank

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (4):
      ARM: at91: gpio: implement request
      ARM: at91: gpio: implement gpio_free
      at91: regroup gpio and pinctrl under a simple-bus
      arm: at91: at91sam9x5: fix gpio number per bank

 Documentation/devicetree/bindings/gpio/gpio_atmel.txt |    5 +++++
 arch/arm/boot/dts/at91sam9260.dtsi                    |   56 +++++++++++++++++++++++++++++++++-----------------------
 arch/arm/boot/dts/at91sam9263.dtsi                    |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
 arch/arm/boot/dts/at91sam9g45.dtsi                    |   87 ++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------
 arch/arm/boot/dts/at91sam9n12.dtsi                    |   79 +++++++++++++++++++++++++++++++++++++++++++++----------------------------------
 arch/arm/boot/dts/at91sam9x5.dtsi                     |   75 ++++++++++++++++++++++++++++++++++++++++++++-------------------------------
 arch/arm/mach-at91/gpio.c                             |   52 +++++++++++++++++++++++++++++++++++++++++-----------
 7 files changed, 271 insertions(+), 181 deletions(-)

Best Regards,
J.
