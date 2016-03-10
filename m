From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Mar 2016 12:58:16 +0700
Subject: [GIT PULL] More RealView DT and misc cleanups
Message-ID: <CACRpkdbm0qQS1mq1xFYrQDt-Q4SfTyx7+2pT+FEJRJGQb1Mmuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

there is nothing controversial or dangerous about these RealView patches,
there is mainly upsides like being able to test and run QEMU on RealView
DT for v4.6.

I'm sorry this was sitting in my tree, I happened to spend my time with
trying to finalize the CLCD changes and delete the board files but that
failed.

This would be nice to have merged and away from my patch stack, but
if it's too late, it's too late, and I'll queue it for v4.7.

Anyways: please pull it in.

Yours,
Linus Walleij


The following changes since commit 1c6e288da6cc3c72579ff0062b5a5684fb9ef90e:

  ARM: versatile: move restart to the device tree (2016-02-15 09:58:08 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-dt-cleanup-2

for you to fetch changes up to b918c87a96254b80c800e3c3b2a502aa06b84b36:

  ARM: realview: hide unused 'pmu_device' object (2016-03-10 12:44:46 +0700)

----------------------------------------------------------------
This is a second set of RealView Device Tree cleanup+additions
that is sitting in my tree for no reason:

- Device Tree defintions for RealView EB, PBA8 and PBX

- CLCD bindings for the standard VGA on RealView PB11MPCore and
  PB1176 using just the existing bindings in the same way as
  Versatile Express is doing it.

- A L2x0 compile cleanup from Arnd that will not be needed once
  we remove the board files (but removal is postponed to v4.7)

- A patch to the SoC driver for Versatile making it print the
  HBI number dynamically.

- A binding blurb for the IB2 syscon on the Versatile.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: realview: hide unused 'pmu_device' object

Linus Walleij (6):
      Documentation/DT: add blurb for IB2 syscon to Versatile
      ARM: PB11MPCore: define a standard VGA panel
      ARM: PB1176: define a standard VGA panel
      soc: versatile: dynamically detect RealView HBI numbers
      ARM: realview: support all the RealView EB board variants
      ARM: realview: DT support for the PBA8 and PBX-A9

 Documentation/devicetree/bindings/arm/arm-boards |   8 +
 arch/arm/boot/dts/Makefile                       |   8 +-
 arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts  |  93 ++++
 arch/arm/boot/dts/arm-realview-eb-11mp.dts       |  74 ++++
 arch/arm/boot/dts/arm-realview-eb-a9mp.dts       |  70 +++
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi        | 225 ++++++++++
 arch/arm/boot/dts/arm-realview-eb.dts            | 166 +++++++
 arch/arm/boot/dts/arm-realview-eb.dtsi           | 453 +++++++++++++++++++
 arch/arm/boot/dts/arm-realview-pb1176.dts        |  40 ++
 arch/arm/boot/dts/arm-realview-pb11mp.dts        |  19 +-
 arch/arm/boot/dts/arm-realview-pba8.dts          | 178 ++++++++
 arch/arm/boot/dts/arm-realview-pbx-a9.dts        | 229 ++++++++++
 arch/arm/boot/dts/arm-realview-pbx.dtsi          | 542 +++++++++++++++++++++++
 arch/arm/mach-realview/realview_pbx.c            |   2 +
 drivers/soc/versatile/soc-realview.c             |  19 +-
 15 files changed, 2101 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-a9mp.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-mp.dtsi
 create mode 100644 arch/arm/boot/dts/arm-realview-eb.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb.dtsi
 create mode 100644 arch/arm/boot/dts/arm-realview-pba8.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-pbx-a9.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-pbx.dtsi
