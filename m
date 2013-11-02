From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Sat,  2 Nov 2013 21:09:29 +0530
Subject: [PATCH v4 0/6] gpio: daVinci: Fixes and feature enhancement
Message-ID: <1383406775-14902-1-git-send-email-prabhakar.csenng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

Patches 1, 2 and 3 are newly added. This patch series does the following
a> Fixes check for offset for unbanked gpios.
b> Ports the driver to use irqdomain.
c> Adds dt binding support for gpio-davinci.
d> Adds DA850 dt support goio.

Changes for v4:
1: Added irqdomain support for the driver.
2: Dropped the ACK's.
3: Removed unnecessary DT property.

This patch series has been tested on DA850 for GPIO7_4
(ie switch 8 on SW7.). Patches can be found at [1].

[1] http://git.linuxtv.org/mhadli/v4l-dvb-davinci_devices.git/shortlog/refs/heads/davinci_gpio

KV Sujith (3):
  gpio: davinci: add OF support
  ARM: davinci: da850: add GPIO DT node
  ARM: davinci: da850 evm: add GPIO pinumux entries DT node

Lad, Prabhakar (3):
  gpio: davinci: Fixed a check for unbanked gpio
  gpio: davinci: remove unnecessary printk
  gpio: davinci: use irqdomain

 .../devicetree/bindings/gpio/gpio-davinci.txt      |   32 ++++++
 arch/arm/boot/dts/da850-evm.dts                    |   20 ++++
 arch/arm/boot/dts/da850.dtsi                       |   15 +++
 arch/arm/mach-davinci/da830.c                      |    1 -
 arch/arm/mach-davinci/da850.c                      |    1 -
 arch/arm/mach-davinci/dm355.c                      |    1 -
 arch/arm/mach-davinci/dm365.c                      |    1 -
 arch/arm/mach-davinci/dm644x.c                     |    1 -
 arch/arm/mach-davinci/dm646x.c                     |    1 -
 drivers/gpio/gpio-davinci.c                        |  111 +++++++++++++++-----
 include/linux/platform_data/gpio-davinci.h         |    3 +-
 11 files changed, 153 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-davinci.txt

-- 
1.7.9.5
