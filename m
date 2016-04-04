From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Apr 2016 10:45:48 +0200
Subject: [GIT PULL] move Versatile flash protection to the device tree
Message-ID: <CACRpkdZxrhkL7a6DG3frKeR+=xF6X4nczepAbqj1PGDs3VsmMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

now I'm tired of waiting for the MTD maintainers' word on this patch
series. I sent a question about this approach on february 13:
http://marc.info/?l=linux-arm-kernel&m=145537026603174&w=2

With subsequent pings on feb 22, mar 5, mar 31, and the cleanup
missing the merge window.

As you can see the flash protection patch also caters for the
RealView flash protection bits.

Please pull this into the ARM SoC tree for testing in linux-next
for the v4.7 series. If the MTD people appear again and have issues
you can always drop the branch.

Yours,
Linus Walleij

The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/versatile-flash-for-arm-soc

for you to fetch changes up to 91011a7605822cd9c16eabcd1cc11ae31d604bfd:

  ARM: integrator: move flash registration to device tree (2016-04-04
10:33:16 +0200)

----------------------------------------------------------------
This is a set of patches removing the board file code
for Versatile flash handling and instead moving it over
to the device tree and a special add-on file.

----------------------------------------------------------------
Linus Walleij (4):
      mtd: physmap_of: add a hook for Versatile write protection
      mtd: augment the "arm,versatile-flash" bindings
      ARM: versatile: move flash registration to the device tree
      ARM: integrator: move flash registration to device tree

 .../devicetree/bindings/mtd/arm-versatile.txt      |  20 +-
 arch/arm/boot/dts/integrator.dtsi                  |   3 +-
 arch/arm/boot/dts/versatile-ab.dts                 |   5 +-
 arch/arm/mach-integrator/integrator_ap.c           |  62 -----
 arch/arm/mach-integrator/integrator_cp.c           |  51 -----
 arch/arm/mach-versatile/versatile_dt.c             |  47 ----
 drivers/mtd/maps/Kconfig                           |  10 +
 drivers/mtd/maps/Makefile                          |   1 +
 drivers/mtd/maps/physmap_of.c                      |   6 +
 drivers/mtd/maps/physmap_of_versatile.c            | 253 +++++++++++++++++++++
 drivers/mtd/maps/physmap_of_versatile.h            |  16 ++
 11 files changed, 310 insertions(+), 164 deletions(-)
 create mode 100644 drivers/mtd/maps/physmap_of_versatile.c
 create mode 100644 drivers/mtd/maps/physmap_of_versatile.h
