From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jul 2017 16:19:02 +0200
Subject: [GIT PULL 1/7] ARM: SoC non-urgent fixes for merge window
Message-ID: <CAK8P3a2jsvGy8tQn2q=c0TTGPR6iH2mHWGbq-+iK2Y-RPHOBUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes-nc

for you to fetch changes up to ff9e0e3b091291a6694c52074940c5fabd693467:

  Merge tag 'mvebu-fixes-4.12-2' of
git://git.infradead.org/linux-mvebu into next/fixes-non-critical
(2017-07-03 14:09:06 +0200)

----------------------------------------------------------------
ARM: SoC non-urgent fixes for merge window

Smaller patches that didn't seem to find a home in other branches, and
low-priority fixes from late in the merge window.

- Lee Jones retires as bcm2835 (raspberry pi) co-maintainer.

- A couple of bugfixes for the ARM CCN bus driver that were
  regarded not important enough

- minor device tree fixes for the Renesas and Marvell platforms,
  that came a little late or did not justify have another
  pull request after the last -rc.

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'ccn/fixes-for-4.13-v2' of
git://git.linaro.org/people/pawel.moll/linux into
next/fixes-non-critical
      Merge tag 'mvebu-fixes-4.12-2' of
git://git.infradead.org/linux-mvebu into next/fixes-non-critical

Eric Anholt (1):
      MAINTAINERS: Remove Lee Jones from bcm2835.

Florian Fainelli (1):
      Merge tag 'bcm2835-maintainers-next-2017-06-08' into maintainers/next

Geert Uytterhoeven (1):
      ARM: dts: armadillo800eva: Split LCD mux and gpio

Heiko Stuebner (1):
      MAINTAINERS: add RV1108 Rockchip soc to maintained files

Javier Martinez Canillas (1):
      bus: arm-ccn: Fix module autoload

Markus Elfring (1):
      bus: arm-ccn: Use devm_kcalloc() in arm_ccn_probe()

Olof Johansson (2):
      Merge tag 'renesas-fixes2-for-v4.12' of
https://git.kernel.org/.../horms/renesas into next/fixes-non-critical
      Merge tag 'arm-soc/for-4.13/maintainers' of
http://github.com/Broadcom/stblinux into next/fixes-non-critical

Peter Korsgaard (1):
      ARM: dts: kirkwood: Fix Openblock A6 nand partition overlap

Velibor Markovski (2):
      dt-bindings: arm-ccn: Add bindings info for CCN-502 compatible string
      bus: arm-ccn: Enable stats for CCN-502 interconnect

 Documentation/devicetree/bindings/arm/ccn.txt        |  1 +
 MAINTAINERS                                          |  2 +-
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts         |  2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts        |  2 ++
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi |  3 +--
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |  3 +--
 drivers/bus/arm-ccn.c                                | 10 ++++++----
 7 files changed, 13 insertions(+), 10 deletions(-)
