From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Mar 2018 12:52:58 -0700
Subject: [GIT PULL 1/2] Broadcom devicetree changes for 4.17
Message-ID: <20180313195259.20496-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.17/devicetree

for you to fetch changes up to e5c851ef012b4b63ea50228da3451f3cfb690c45:

  Merge tag 'bcm2835-dt-next-2018-03-13' into devicetree/next (2018-03-13 11:44:16 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs devicetree changes
for 4.17, please pull the following:

- Henry fixes the pin functions for the JTAG pins, nothing uses this for
  now, but it could be backported eventually if deemed appropriate

- Stefan fixes the register ranges for the bcm2835-i2s nodes in the
  binding document definition, he then fixes the probing of the
  bcm2835-i2s driver by providing an appropriate register range and a
  missing clock. Stefan also makes sure that the appropriate pull
  settings are applied to the pins used on the Raspberry Pi Zero
  Wireless, he then adds the necessary UART node to connected to the
  BCM43438 Bluetooth adapter on the Pi Zero W. He finally enables USB
  OTG mode on the Pi Zero W since he became usable again

- Baruch adds the necessary Device Tree nodes to support the Raspberry
  Pi GPIO expander which is controlled via the VC4 firmware

- Hiroshi adds the missing LEDs on the Buffalo WZR-900DHP router

- Eric adds the DPI hardware block into the BCM283x Device Tree include
  file for future use when an actual panel is available

- Florian updates the Northstar Plus platforms to use port 8 of the
  internal switch as the CPU/management port since necessary code was
  added in the b53 switch driver to support that

----------------------------------------------------------------
Baruch Siach (2):
      ARM: dts: bcm2835: make the firmware node into a bus
      ARM: dts: bcm2837-rpi-3-b: add GPIO expander

Eric Anholt (1):
      ARM: bcm2835: Add the DPI hardware to the device tree.

Florian Fainelli (3):
      Merge tag 'bcm2835-dt-next-2018-02-28' into devicetree/next
      ARM: dts: NSP: Switch to port 8 for CPU port
      Merge tag 'bcm2835-dt-next-2018-03-13' into devicetree/next

Henry Zhang (1):
      ARM: dts: bcm283x: Fix pin function of JTAG pins

INAGAKI Hiroshi (1):
      ARM: dts: BCM5301X: add missing LEDs for Buffalo WZR-900DHP

Stefan Wahren (5):
      dt-bindings: bcm283x: Fix register ranges of bcm2835-i2s
      ARM: dts: bcm283x: Fix probing of bcm2835-i2s
      ARM: dts: bcm283x: Apply pull settings to Zero W relevant groups
      ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial slave
      ARM: dts: bcm2835-rpi-zero-w: Enable OTG mode

 .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   |  4 +-
 .../devicetree/bindings/sound/brcm,bcm2835-i2s.txt |  9 ++-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           | 16 ++++-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              | 17 ++++++
 arch/arm/boot/dts/bcm283x.dtsi                     | 20 ++++++-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  | 68 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm958622hr.dts                  |  6 +-
 arch/arm/boot/dts/bcm958623hr.dts                  |  6 +-
 arch/arm/boot/dts/bcm958625hr.dts                  |  6 +-
 arch/arm/boot/dts/bcm958625k.dts                   |  6 +-
 arch/arm/boot/dts/bcm988312hr.dts                  |  6 +-
 12 files changed, 140 insertions(+), 28 deletions(-)
