From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 03 Jan 2017 21:35:00 -0800
Subject: [GIT PULL] Amlogic fixes for v4.10-rc
Message-ID: <7hk2abgzgb.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This pull has one real fix, as a couple non-critical ones.  The DRM
DT/defconfig patches are coming now because I didn't expect the new
driver to make it for the v4.10 merge window, but since it did[1], the
DT and defconfig should go into the same release.

Thanks,

Kevin

[1] bbbe775ec5b5 drm: Add support for Amlogic Meson Graphic Controller

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes

for you to fetch changes up to fcdaf1a2a7a042a290f4c7de28bcdebd5de18445:

  ARM64: defconfig: enable DRM_MESON as module (2017-01-03 09:31:13 -0800)

----------------------------------------------------------------
Amlogic fixes for v4.10
- DT: GXL: fix GPIO include
- add DT and defconfig for newly merged DRM driver

----------------------------------------------------------------
Kevin Hilman (2):
      ARM64: dts: meson-gxl: fix GPIO include
      ARM64: defconfig: enable DRM_MESON as module

Neil Armstrong (1):
      ARM64: dts: meson-gx: Add Graphic Controller nodes

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi              | 16 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts | 16 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi       | 16 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi            |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts  | 16 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi             |  6 +++++-
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts    | 16 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi             |  4 ++++
 arch/arm64/configs/defconfig                           |  1 +
 9 files changed, 94 insertions(+), 1 deletion(-)
