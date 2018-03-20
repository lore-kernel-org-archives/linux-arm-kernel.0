From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 19 Mar 2018 17:09:30 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.17
Message-ID: <7hd0zzr4jp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to c339f0e29ce9f9cd1cd2b6759a29a298bce1e948:

  ARM64: dts: meson-gx: make efuse read-only (2018-03-19 16:44:39 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.17
- AXG: add/enable UART_A, I2C, RMII, system controller, HW RNG
- accept MAC from u-boot environment
- misc. fixes

----------------------------------------------------------------
Jerome Brunet (6):
      ARM64: dts: meson-gxl: add internal ethernet PHY irq
      ARM64: meson-axg: enable hardware rng
      ARM64: dts: meson-axg: add sec_AO system controller
      ARM64: dts: meson-axg: fix pwm_AO_cd compatible
      ARM64: dts: meson: reduce odroid-c2 eMMC maximum rate
      ARM64: dts: meson-gx: make efuse read-only

Jian Hu (3):
      ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC
      ARM64: dts: meson-axg: describe pin DT info for I2C controller
      ARM64: dts: meson-axg: enable I2C Master-1 for the audio speaker

Jorge Ramirez-Ortiz (2):
      ARM64: dts: meson s905x: accept MAC addr from u-boot environment
      ARM64: dts: meson: accept MAC addr from u-boot environment

Neil Armstrong (4):
      ARM64: dts: amlogic: Convert to new-style SPDX license identifiers
      ARM64: dts: meson-gxbb-wetek: add a wetek specific dtsi to cleanup hub and play2
      meson-gx-socinfo: Add package id for S905H
      ARM64: dts: meson: bump mali450 clk to 744MHz

Yixun Lan (6):
      ARM64: dts: meson: uart: fix address space range
      ARM64: dts: meson-axg: add RMII pins for ethernet controller
      ARM64: dts: meson-axg: uart: drop legacy compatible name from EE UART
      ARM64: dts: meson-axg: uart: Add the pinctrl info description
      ARM64: dts: meson-axg: complete the pinctrl info for UART_AO_A
      ARM64: dts: meson-axg: enable the UART_A controller

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                 |  18 ++++-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                     | 279 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            |  40 +---------
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                      |  50 ++-----------
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           |  42 +----------
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         |  40 +---------
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            |  42 +----------
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts                |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts                |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               |  40 +---------
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts       |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts        |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts      |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           |  40 +---------
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts           |  82 +--------------------
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts         | 122 ++-----------------------------
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi              | 256 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                    |  50 ++-----------
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi                |  14 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts           |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts           |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi               |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |   4 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |   4 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |   4 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  40 +---------
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts           |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          |   4 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi               |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                     |  40 +---------
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts          |   3 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            |  40 +---------
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts                 |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts                 |  39 +---------
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             |  40 +---------
 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts             |   3 +-
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi                     |  39 +---------
 drivers/soc/amlogic/meson-gx-socinfo.c                         |   1 +
 38 files changed, 620 insertions(+), 1185 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
