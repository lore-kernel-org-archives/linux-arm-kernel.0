From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Mar 2015 08:50:09 +0100
Subject: [GIT PULL] simple-mfd cleanup
Message-ID: <CACRpkdYd3eHZK6vcJQDtuPQXa2GoGA3sEPb8yu8r21CmWpfvNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

as discussed back and forth with Lee Jones & Arnd, here is the patch
set adding the "simple-mfd" subtree analogous to "simple-bus". I have
not got the attentions of some subsystem maintainers but I'm out of
patience and thus assume they just don't care. However for us in the ARM
OF/DT camp this is of great value.

It is mainly a cleanup, but since the Juno + ARM64 LED support depend
on it that has been added on top, tell me if you prefer that in a separate
pull request and I'll send you two individual ones instead.

Cleanups from Antoine Tenart and Alexandre Belloni depend on this.

Please pull this in.

Yours,
Linus Walleij

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/simple-mfd

for you to fetch changes up to 6bc267ba08f121c1ecde854abb15cf58f4f07ca1:

  arm64: add LEDs and some trigger support to defconfig (2015-03-25
08:41:20 +0100)

----------------------------------------------------------------
Support for "simple-mfd" compatible subtrees and updates
to drivers and device trees to account for this.

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
