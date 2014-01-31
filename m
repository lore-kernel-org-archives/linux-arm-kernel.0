From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 30 Jan 2014 16:54:09 -0800
Subject: [GIT PULL] ARM: SoC late DT changes for v3.14
Message-ID: <87iot1ug26.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

These are a few changes that arrived a little late but were considered
self-contained enough to still go in for v3.14.

They are all device tree updtes this time around, and mainly for
Broadcom SoCs.

There is one trivial add/add conflict in one of the device tree files.

Please pull,

Kevin


----------------------------------------------------------------

The following changes since commit 53d8ab29f8f6d67e37857b68189b38fa3d87dd8e:

  Merge branch 'for-3.14/drivers' of git://git.kernel.dk/linux-block

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/late-dt-for-linus

for you to fetch changes up to 929267cb3525daf72f730f4d4c4e1e9e2b135e61:

  ARM: moxart: move fixed rate clock child node to board level dts

----------------------------------------------------------------

Alex Elder (1):
      clk: bcm281xx: define kona clock binding

Jonas Jensen (1):
      ARM: moxart: move fixed rate clock child node to board level dts

Kevin Hilman (1):
      Merge tag 'bcm-for-3.14-dt' of git://github.com/broadcom/bcm11351 into next/dt

Matt Porter (1):
      ARM: dts: add usb udc support to bcm281xx

Tim Kryger (8):
      ARM: dts: bcm28155-ap: Enable all the i2c busses
      ARM: dts: Declare clocks as fixed on bcm11351
      ARM: dts: bcm281xx: Add i2c busses
      ARM: dts: Specify clocks for UARTs on bcm11351
      Documentation: dt: kona-sdhci: Add clocks property
      ARM: dts: Specify clocks for SDHCIs on bcm11351
      Documentation: dt: kona-timer: Add clocks property
      ARM: dts: Specify clocks for timer on bcm11351


 .../devicetree/bindings/arm/bcm/kona-timer.txt  |   7 +-
 .../bindings/clock/bcm-kona-clock.txt           |  93 ++++++++++
 .../devicetree/bindings/mmc/kona-sdhci.txt      |   4 +
 arch/arm/boot/dts/bcm11351-brt.dts              |   6 +
 arch/arm/boot/dts/bcm11351.dtsi                 | 169 ++++++++++++++++++-
 arch/arm/boot/dts/bcm28155-ap.dts               |  28 +++
 arch/arm/boot/dts/moxart-uc7112lx.dts           |   8 +
 arch/arm/boot/dts/moxart.dtsi                   |   6 -
 8 files changed, 309 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/bcm-kona-clock.txt
