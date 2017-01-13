From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 13 Jan 2017 10:17:10 -0800
Subject: [GIT PULL] Amlogic fixes for v4.10-rc4
Message-ID: <m2inpi6d09.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull a couple fixes for v4.10-rc.

The branch is based on v4.10-rc3 to not conflict with another DT fix
that when in for -rc2.

Kevin


The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes-2

for you to fetch changes up to 64a8225e9f9dec0e5cd2f5640743699056da4e4e:

  ARM64: dts: meson-gx: Add reserved memory zone and usable memory range (2017-01-12 17:00:50 -0800)

----------------------------------------------------------------
Amlogic fixes for v4.10-rc4
- odroid-c2: disable DVFS to avoid crashes due to broken SCPI
- fix misc. crashes by adding known reserved memory regions

----------------------------------------------------------------
Neil Armstrong (2):
      ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS
      ARM64: dts: meson-gx: Add reserved memory zone and usable memory range

 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi       |  5 -----
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                 | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts       | 10 +++++++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts           |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts           |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi          |  5 -----
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi               |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts     |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts      |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts      |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts       |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts       |  9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts       |  9 +++++++++
 18 files changed, 111 insertions(+), 19 deletions(-)
