From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 16 Sep 2016 16:40:02 +0900
Subject: [PATCH v7 0/2] clk: uniphier: add clock drivers for UniPhier SoCs
Message-ID: <1474011604-12577-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I split into two patches to make review easier.

 1/2: core support code
 2/2: data arrays


Changes in v7:
  - Add static to probe/remove callbacks
  - Fill unused idx of clk array with ERR_PTR(-EINVAL)
  - Use of_device_get_match_data() instead of of_match_node()
  - Remove CLK_IS_BASIC flag
  - Make drivers built-in only
  - Remove bogus  #include <linux/bitops.h>

Changes in v6:
  - Fix provided clock description a bit

Changes in v5:
  - Assign each gating register bit with a separate clk
  - Fix examples in binding document to add specific compatible
  - Document provided clocks for system clock

Changes in v4:
  - Unify module_platform_driver() boilerplate into a single place
  - Add binding document
  - Add USB3 clocks

Changes in v3:
  - Change to platform drivers instead of OF_CLK_DECLARE
  - Split into a core part + SoC drivers
    SoC drivers just consist of tables of SoC-specific data.
    This allows reviewer to concentrate on the core-part
  - Hard-code parent clock names for cascading

Changes in v2:
  - split emmc_hw_reset
  - make SD clock rate-controllable
  - add CLK_SET_RATE_PARENT flag to mux, gate, fixed-factor clocks

Masahiro Yamada (2):
  clk: uniphier: add core support code for UniPhier clock driver
  clk: uniphier: add clock data for UniPhier SoCs

 .../devicetree/bindings/clock/uniphier-clock.txt   | 134 +++++++++++++
 MAINTAINERS                                        |   1 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/uniphier/Kconfig                       |   9 +
 drivers/clk/uniphier/Makefile                      |   8 +
 drivers/clk/uniphier/clk-uniphier-core.c           | 214 +++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier-fixed-factor.c   |  48 +++++
 drivers/clk/uniphier/clk-uniphier-fixed-rate.c     |  47 +++++
 drivers/clk/uniphier/clk-uniphier-gate.c           |  97 ++++++++++
 drivers/clk/uniphier/clk-uniphier-mio.c            | 101 ++++++++++
 drivers/clk/uniphier/clk-uniphier-mux.c            |  95 +++++++++
 drivers/clk/uniphier/clk-uniphier-peri.c           |  57 ++++++
 drivers/clk/uniphier/clk-uniphier-sys.c            | 151 +++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h                | 122 ++++++++++++
 15 files changed, 1086 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/uniphier-clock.txt
 create mode 100644 drivers/clk/uniphier/Kconfig
 create mode 100644 drivers/clk/uniphier/Makefile
 create mode 100644 drivers/clk/uniphier/clk-uniphier-core.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-fixed-factor.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-fixed-rate.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-gate.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-mio.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-mux.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-peri.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-sys.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier.h

-- 
1.9.1
