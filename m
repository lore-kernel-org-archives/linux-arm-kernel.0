From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 30 Nov 2017 15:15:47 -0800
Subject: [GIT PULL] Amlogic fixes for v4.15-rc
Message-ID: <7hefofpdcs.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A handful of minor v4.15 fixes for Amlogic family SoCs.  They're mostly
DT, but some trivial non-DT stuff mixed in.  Let me know if you prefer
those in separate pulls, and I will do so.

Thanks,

Kevin


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes

for you to fetch changes up to 1142a3a457d007910df95acc7983d4d7be49645a:

  meson-gx-socinfo: Fix package id parsing (2017-11-29 15:58:00 -0800)

----------------------------------------------------------------
Amlogic fixes for v4.15-rc
- GPIO interrupt fixes
- new nodes for drivers merged late (VPU domains)
- socinfo fix for GX series
- fix typo

----------------------------------------------------------------
Arnaud Patard (1):
      meson-gx-socinfo: Fix package id parsing

Colin Ian King (1):
      ARM: meson: fix spelling mistake: "Couln't" -> "Couldn't"

Martin Blumenstingl (2):
      ARM: dts: meson: correct the sort order for the the gpio_intc node
      ARM: dts: meson: fix the memory region of the GPIO interrupt controller

Neil Armstrong (4):
      ARM64: dts: meson-gx: add VPU power domain
      ARM64: dts: meson-gx: Add HDMI_5V regulator on selected boards
      ARM64: dts: meson-gx: grow reset controller memory zone
      ARM64: dts: odroid-c2: Add HDMI and CEC Nodes

 arch/arm/boot/dts/meson.dtsi                                 | 18 +++++++++---------
 arch/arm/mach-meson/platsmp.c                                |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    | 13 ++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts          | 30 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                  | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts         |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts         |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi        | 11 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        | 12 ++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c                       |  4 ++--
 14 files changed, 190 insertions(+), 13 deletions(-)
