From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 15 Mar 2018 12:55:41 +0100
Subject: [PATCH 0/4] ARM64: dts: meson: hhi syscon and clock controllers
Message-ID: <20180315115545.1884-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HHI register region provides more than just clocks. Several drivers may
need to access this region, such as the clock controllers and the display
driver.

Meson-gx clock controllers has been developed and merged before we knew the
hhi could be needed elsewhere, which is why it requests the region directly.
Meson-axg was built following the model of meson-gx.

To fix this situation, the clock controller should be a child of the hhi
system controllers. The hhi system controller node already exists on meson-gx.
It needs to be added on the axg.

This changeset depends on [0]. This dependency has been merged in
clk-next. A topic branch is available here [1]

[0]: https://lkml.kernel.org/r/20180212145846.19380-1-jbrunet at baylibre.com
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-amlogic

Jerome Brunet (4):
  dt-bindings: clock: meson: update documentation with hhi syscon
  ARM64: dts: meson-gx: sysctrl is the parent of the clock controller
  ARM64: dts: meson-axg: use hhi syscon for the clock controller
  ARM64: dts: meson-gx: fix gxl clock controller compatible

 .../devicetree/bindings/clock/amlogic,gxbb-clkc.txt      | 16 +++++++++++-----
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi               | 12 ++++++++----
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi              |  5 ++---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi               |  7 +++----
 4 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.14.3
