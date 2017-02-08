From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Feb 2017 18:07:42 +0100
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <2374919.NrmJFMXx0l@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7a308bb3016f57e5be11a677d15b821536419d36:

  Linux 4.10-rc5 (2017-01-22 12:54:15 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 5aff1d245e8cc1ab5c4517d916edaed9e3f7f973:

  ARM: defconfigs: make NF_CT_PROTO_SCTP and NF_CT_PROTO_UDPLITE built-in (2017-02-06 17:37:42 +0100)

----------------------------------------------------------------
ARM: SoC fixes for v4.10

- A relatively large patch restores booting on i.MX platforms that
  failed to boot after a cleanup was merged for v4.10.

- A quirk for USB needs to be enabled on the STi platform

- On the Meson platform, we saw memory corruption with part of
  the memory used by the secure monitor, so we have to stay out
  of that area.

- The same platform also has a problem with ethernet under load,
  which is fixed by disabling EEE negotiation.

- imx6dl has an incorrect pin configuration, which prevents SPI
  from working.

- Two maintainers have lost their access to their email addresses, so
  we should update the MAINTAINERS file before the release

- Renaming one of the orion5x linkstation models to help simplify
  the debian install.

- A couple of fixes for build warnings that were introduced during
  v4.10-rc.

----------------------------------------------------------------
Arnd Bergmann (5):
      ARM: imx: hide unused variable in #ifdef
      Merge tag 'imx-fixes-4.10-3' of git://git.kernel.org/.../shawnguo/linux into HEAD
      ARM: orion5x: fix Makefile for linkstation-lschl.dtb
      Merge tag 'mvebu-fixes-4.10-1' of git://git.infradead.org/linux-mvebu into fixes
      ARM: defconfigs: make NF_CT_PROTO_SCTP and NF_CT_PROTO_UDPLITE built-in

Dinh Nguyen (1):
      MAINTAINERS: socfpga: update email for Dinh Nguyen

Fabio Estevam (1):
      ARM: dts: imx: Pass 'chosen' and 'memory' nodes

Jerome Brunet (1):
      ARM64: dts: meson-gxbb-odroidc2: fix GbE tx link breakage

Ludovic Desroches (1):
      MAINTAINERS: change email address from atmel to microchip

Neil Armstrong (1):
      ARM64: dts: meson-gx: Add firmware reserved memory zones

Nicolas Ferre (1):
      MAINTAINERS: at91: change email address

Olof Johansson (2):
      Merge tag 'sti-dt-for-v4.10-rc' of git://git.kernel.org/.../pchotard/sti into fixes
      Merge tag 'at91-ab-4.10-soc' of git://git.kernel.org/.../abelloni/linux into fixes

Patrice Chotard (1):
      ARM: dts: STiH407-family: set snps,dis_u3_susphy_quirk

Roger Shimizu (2):
      ARM: dts: orion5x-lschl: Fix model name
      ARM: dts: orion5x-lschl: More consistent naming on linkstation series

S?bastien Szymanski (1):
      ARM: dts: imx6dl: fix GPIO4 range

 MAINTAINERS                                        | 36 +++++++++++-----------
 arch/arm/boot/dts/Makefile                         |  2 +-
 arch/arm/boot/dts/imx1.dtsi                        |  8 +++++
 arch/arm/boot/dts/imx23.dtsi                       |  8 +++++
 arch/arm/boot/dts/imx25.dtsi                       |  8 +++++
 arch/arm/boot/dts/imx27.dtsi                       |  8 +++++
 arch/arm/boot/dts/imx28.dtsi                       |  8 +++++
 arch/arm/boot/dts/imx31.dtsi                       |  8 +++++
 arch/arm/boot/dts/imx35.dtsi                       |  8 +++++
 arch/arm/boot/dts/imx50.dtsi                       |  8 +++++
 arch/arm/boot/dts/imx51.dtsi                       |  8 +++++
 arch/arm/boot/dts/imx53.dtsi                       |  8 +++++
 arch/arm/boot/dts/imx6dl.dtsi                      |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +++++
 arch/arm/boot/dts/imx6sl.dtsi                      |  8 +++++
 arch/arm/boot/dts/imx6sx.dtsi                      |  8 +++++
 arch/arm/boot/dts/imx6ul.dtsi                      |  8 +++++
 arch/arm/boot/dts/imx7s.dtsi                       |  8 +++++
 ...n5x-lschl.dts => orion5x-linkstation-lschl.dts} |  4 +--
 arch/arm/boot/dts/stih407-family.dtsi              |  1 +
 arch/arm/configs/ezx_defconfig                     |  4 +--
 arch/arm/configs/imote2_defconfig                  |  4 +--
 arch/arm/mach-imx/mmdc.c                           |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 18 +++++++++++
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 12 ++++++++
 25 files changed, 178 insertions(+), 27 deletions(-)
 rename arch/arm/boot/dts/{orion5x-lschl.dts => orion5x-linkstation-lschl.dts} (98%)
