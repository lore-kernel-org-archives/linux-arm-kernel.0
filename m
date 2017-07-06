From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  6 Jul 2017 12:24:20 +0200
Subject: [PATCH 0/3] clk: meson: gxbb-aoclk: Add CEC 32k clock
Message-ID: <1499336663-23875-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the standalone CEC Controller on the Amlogic SoCs,
a specific CEC 32K clock must be handled in the AO domain.

The CEC 32K AO Clock is a dual divider with dual counter to provide a more
precise 32768Hz clock for the CEC subsystem from the external xtal.

The AO clocks management registers are spread among the AO register space,
so this patch also adds management of these registers mappings then uses them
for the CEC 32K AO clock management.

This patchset :
 - updates the bindings accordingly
 - adds the CEC 32k clock
 - adds the clock binding entry

The DT Update will be sent in another patchset.

Neil Armstrong (3):
  dt-bindings: clock: gxbb-aoclk: Add CEC 32k clock
  clk: meson: gxbb-aoclk: Add CEC 32k clock
  dt-bindings: clock: amlogic,gxbb-aoclkc: Update bindings

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  11 +-
 drivers/clk/meson/Makefile                         |   2 +-
 drivers/clk/meson/gxbb-aoclk-32k.c                 | 188 +++++++++++++++++++++
 drivers/clk/meson/gxbb-aoclk.c                     |  59 ++++++-
 drivers/clk/meson/gxbb-aoclk.h                     |  23 +++
 include/dt-bindings/clock/gxbb-aoclkc.h            |   1 +
 6 files changed, 275 insertions(+), 9 deletions(-)
 create mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c
 create mode 100644 drivers/clk/meson/gxbb-aoclk.h

-- 
1.9.1
