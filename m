From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 May 2015 09:26:22 +0200
Subject: [GIT PULL] simple-mfd
Message-ID: <CACRpkdYcabVWJb8tm1E+aGotaH43-T+no=jm5QXy7zOe101u4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

as requested by Arnd Bergmann:
http://marc.info/?l=linux-arm-kernel&m=142896799229591&w=2

I'm sending the simple-mfd patchset again, this based on v4.1-rc3.
Please merge this for cleanups, other people's cleanups depend
on it too.

Yours,
Linus Walleij


The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/simple-mfd

for you to fetch changes up to 48f1a9a4e268dec7c7f3e79339cfb85699c48eb0:

  arm64: add LEDs and some trigger support to defconfig (2015-05-11
08:55:04 +0200)

----------------------------------------------------------------
Simple MFD base patches and cleanups:
- Document MFD DT bindings
- Instantiate subdevices for simple MFDs
- Switch Integrator and RealView to use the simple MFD
- Augment LED driver to probe from platform device
- Add LEDs to Juno Vexpress64

----------------------------------------------------------------
Linus Walleij (5):
      MFD/OF: document MFD devices and handle simple-mfd
      ARM: dts: update syscons to use simple-mfd
      leds: syscon: instantiate from platform device
      arm64: juno: Add APB registers and LEDs using syscon
      arm64: add LEDs and some trigger support to defconfig

 Documentation/devicetree/bindings/mfd/mfd.txt |  41 +++++++
 arch/arm/boot/dts/arm-realview-pb1176.dts     |   2 +-
 arch/arm/boot/dts/integrator.dtsi             |   4 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi |  68 +++++++++++
 arch/arm64/configs/defconfig                  |   6 +
 drivers/leds/leds-syscon.c                    | 170 +++++++++++++-------------
 drivers/of/platform.c                         |   1 +
 7 files changed, 204 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mfd.txt
