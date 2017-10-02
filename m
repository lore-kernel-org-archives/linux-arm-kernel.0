From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 02 Oct 2017 10:36:38 -0700
Subject: [GIT PULL] Amlogic fixes for v4.14-rc
Message-ID: <7hr2ul8na1.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

This is the same DT series that was sent for next/late but was missed,
so I'm sending it again as fixes for v4.14-rc since we have some users
having issues because the driver was merged for v4.14, but the
correspnding DT enhancements were not.

Please merge for v4.14-rc3.  It's unmodified since the previous pull request.

Thanks,

Kevin


The following changes since commit 47884c5c746ee7c02e06fbf60480e0f13aa11dfe:

  ARM64: dts: meson-gxl-libretech-cc: Add GPIO lines names (2017-08-22 15:37:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-3

for you to fetch changes up to 485a308f05d843034b6e82f688704c44888aecde:

  ARM64: dts: meson-gxbb: nanopi-k2: enable sdr104 mode (2017-09-05 12:05:01 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.14 (round 3)
- updates for new MMC driver features/fixes
- support high-speed modes

----------------------------------------------------------------
Jerome Brunet (9):
      ARM64: dts: meson-gx: Use correct mmc clock source 0
      ARM64: dts: meson: remove cap-sd-highspeed from emmc nodes
      ARM64: dts: meson: add mmc clk gate pins
      ARM64: dts: meson-gxbb: nanopi-k2: add card regulator settle times
      ARM64: dts: meson-gxl: libretech-cc: add card regulator settle times
      ARM64: dts: meson-gxl: libretech-cc: enable high speed modes
      ARM64: dts: meson-gxbb: p20x: enable sdcard UHS modes
      ARM64: dts: meson-gxbb: nanopi-k2: enable sdcard UHS modes
      ARM64: dts: meson-gxbb: nanopi-k2: enable sdr104 mode

 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            | 10 ++++++----
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           | 19 ++++++++++++++-----
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         | 12 +++++++-----
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            |  9 +++++----
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               | 13 +++++++++----
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           | 10 ++++++----
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                    | 39 ++++++++++++++++++++++++++++++++++++---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |  7 ++++---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 13 +++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 10 ++++++----
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          | 10 ++++++----
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                     | 39 ++++++++++++++++++++++++++++++++++++---
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            |  7 ++++---
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             |  1 -
 14 files changed, 150 insertions(+), 49 deletions(-)
