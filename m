From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 4 Aug 2017 18:18:22 +0200
Subject: [GIT PULL] Amlogic clock driver updates for 4.14
Message-ID: <894174b4-63d5-1e7d-c518-5bba150178ab@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Below is a request to pull the Amlogic clock driver updates for 4.14.

Thanks,
Neil

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://github.com/baylibre/clk-meson.git tags/meson-clk-for-4.14

for you to fetch changes up to 62ec0b9754aced0b4c02694886cbe9bfd3d00f2f:

  clk: meson: gxbb-aoclk: Add CEC 32k clock (2017-08-04 18:02:02 +0200)

----------------------------------------------------------------
Amlogic clock driver updates for 4.14

* meson8b: add the reset controller to the clkc
* meson: expose all clk ids
* gxbb-aoclk: Add CEC 32k clock
* gxbb: add mmc input 0 clocks
* meson: fix protection against undefined clks
* gxbb: fix audio divider flags

----------------------------------------------------------------
Jerome Brunet (8):
      clk: meson: meson8b: fix protection against undefined clks
      clk: meson: gxbb: fix protection against undefined clks
      clk: meson8b: expose every clock in the bindings
      clk: meson-gxbb: expose almost every clock in the bindings
      clk: meson: gxbb: Add sd_emmc clk0 clkids
      clk: meson: gxbb: fix meson cts_amclk divider flags
      clk: meson: gxbb: fix clk_mclk_i958 divider flags
      clk: meson: gxbb: Add sd_emmc clk0 clocks

Martin Blumenstingl (2):
      dt-bindings: clock: meson8b: describe the embedded reset controller
      clk: meson: meson8b: register the built-in reset controller

Neil Armstrong (4):
      dt-bindings: clock: gxbb-aoclk: Add CEC 32k clock
      dt-bindings: clock: amlogic, gxbb-aoclkc: Update bindings
      clk: meson: gxbb-aoclk: Switch to regmap for register access
      clk: meson: gxbb-aoclk: Add CEC 32k clock

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  22 ++-
 .../bindings/clock/amlogic,meson8b-clkc.txt        |   9 +-
 drivers/clk/meson/Kconfig                          |   1 +
 drivers/clk/meson/Makefile                         |   2 +-
 drivers/clk/meson/gxbb-aoclk-32k.c                 | 194 +++++++++++++++++++++
 drivers/clk/meson/gxbb-aoclk-regmap.c              |  46 +++++
 drivers/clk/meson/gxbb-aoclk.c                     |  65 ++++---
 drivers/clk/meson/gxbb-aoclk.h                     |  42 +++++
 drivers/clk/meson/gxbb.c                           | 189 +++++++++++++++++++-
 drivers/clk/meson/gxbb.h                           | 125 ++-----------
 drivers/clk/meson/meson8b.c                        | 160 +++++++++++++++--
 drivers/clk/meson/meson8b.h                        | 112 ++----------
 include/dt-bindings/clock/gxbb-aoclkc.h            |   1 +
 include/dt-bindings/clock/gxbb-clkc.h              |  63 +++++++
 include/dt-bindings/clock/meson8b-clkc.h           |  70 ++++++++
 .../dt-bindings/reset/amlogic,meson8b-clkc-reset.h |  27 +++
 16 files changed, 870 insertions(+), 258 deletions(-)
 create mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c
 create mode 100644 drivers/clk/meson/gxbb-aoclk-regmap.c
 create mode 100644 drivers/clk/meson/gxbb-aoclk.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson8b-clkc-reset.h
