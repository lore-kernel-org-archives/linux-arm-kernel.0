From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 28 Jul 2018 00:15:18 +0530
Subject: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl SoCs
Message-ID: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds Reset Controller (RMU) support for Actions Semi
Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
the clock subsystem in hardware. Hence, in software we integrate RMU
support into common clock driver inorder to maintain compatibility.

This patch series depends on the recently posted S700 clk series:
"[PATCH v7 0/5] Add clock driver for Actions S700 SoC". For the S700 clk
series, driver and bindings patches are applied through the clk tree.
But the DTS patches are not yet picked up by the platform maintainer,
Andreas.

Hence, Andreas is expected to pick the DTS patches in this series once
reviewed by the maintainers along with S700 clk DTS patches.

Because of the absence of the S500 SoC clk support, the reset controller
registration code is added to both S700 and S900 SoC clk drivers for now.
But once S500 clk support is added, the reset controller registration part
will be moved to Owl SoCs common clk code.

Thanks,
Mani

Manivannan Sadhasivam (9):
  clk: actions: Cache regmap info in private clock descriptor
  dt-bindings: clock: Add reset controller bindings for Actions Semi Owl
    SoCs
  dt-bindings: reset: Add binding constants for Actions Semi S700 RMU
  dt-bindings: reset: Add binding constants for Actions Semi S900 RMU
  arm64: dts: actions: Add Reset Controller support for S700 SoC
  arm64: dts: actions: Add Reset Controller support for S900 SoC
  clk: actions: Add Actions Semi Owl SoCs Reset Management Unit support
  clk: actions: Add Actions Semi S700 SoC Reset Management Unit support
  clk: actions: Add Actions Semi S900 SoC Reset Management Unit support

 .../bindings/clock/actions,owl-cmu.txt        |  2 +
 arch/arm64/boot/dts/actions/s700.dtsi         |  2 +
 arch/arm64/boot/dts/actions/s900.dtsi         |  2 +
 drivers/clk/actions/Kconfig                   |  1 +
 drivers/clk/actions/Makefile                  |  1 +
 drivers/clk/actions/owl-common.c              |  3 +-
 drivers/clk/actions/owl-common.h              |  5 +-
 drivers/clk/actions/owl-reset.c               | 72 ++++++++++++++++
 drivers/clk/actions/owl-reset.h               | 32 +++++++
 drivers/clk/actions/owl-s700.c                | 55 +++++++++++-
 drivers/clk/actions/owl-s900.c                | 86 ++++++++++++++++++-
 .../dt-bindings/reset/actions,s700-reset.h    | 34 ++++++++
 .../dt-bindings/reset/actions,s900-reset.h    | 65 ++++++++++++++
 13 files changed, 354 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/actions/owl-reset.c
 create mode 100644 drivers/clk/actions/owl-reset.h
 create mode 100644 include/dt-bindings/reset/actions,s700-reset.h
 create mode 100644 include/dt-bindings/reset/actions,s900-reset.h

-- 
2.17.1
