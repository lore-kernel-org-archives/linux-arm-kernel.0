From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Jun 2013 10:24:51 +0200
Subject: [GIT PULL] Nomadik DT take 2 and Nomadik clocks
Message-ID: <CACRpkdZNPOnhVRsd1AGEiOCmPQDBadcLhctP-OwsGP+DRLa9Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is another batch of Nomadik patches. This should preferably
be merged on top of your nomadik/dt branch (I've based it on top
of that).

Since the clock patches are totally devicetreeified, this needs to
go in on top of the DT stuff.

Yours,
Linus Walleij


The following changes since commit 49932f5ef13fa6a5a8bd71cf2f0b721d0e0b495d:

  ARM: nomadik: move the pin configuration to DT (2013-05-26 22:25:36 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-dt-2

for you to fetch changes up to c641d4dfef6d462c6d66a6fb57700086cd2f0106:

  ARM: nomadik: add the new clocks to the device tree (2013-06-20
10:15:48 +0200)

----------------------------------------------------------------
Nomadik DT and clock work:
- Lee Jones' pinctrl compat ontology patches
- A real clock driver for the Nomadik, 100% DT-based
- Device tree changes for the Nomadik clocks

----------------------------------------------------------------
Lee Jones (2):
      ARM: nomadik: Standardise Nomadik STN8815 based Pinctrl compat
string in the DTS
      pinctrl/nomadik: Standardise Pinctrl compat string for Nomadik
based platforms

Linus Walleij (2):
      clk: nomadik: implement the Nomadik clocks properly
      ARM: nomadik: add the new clocks to the device tree

 .../devicetree/bindings/clock/st,nomadik.txt       | 104 ++++
 arch/arm/boot/dts/ste-nomadik-s8815.dts            |   6 +
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 503 +++++++++++++++++--
 drivers/clk/clk-nomadik.c                          | 551 ++++++++++++++++++++-
 drivers/pinctrl/pinctrl-nomadik.c                  |   2 +-
 5 files changed, 1124 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/st,nomadik.txt
