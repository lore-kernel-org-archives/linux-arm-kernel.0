From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 18 Jul 2018 09:12:47 +0200
Subject: [PATCH v4 0/4] add mailbox support for i.MX7D
Message-ID: <20180718071251.8857-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

20180618 changes v4:
- DT: change fsl,mu-side-a to fsl,mu-side-b
- DT: split the patches.
- DT: add all currently known SoCs.
- imx-mailbox: free allocated irq name on channel shutdown
- imx-mailbox: rename *_imx7 functions to *_generic

20180615 changes v3:
- DT: remove prosaic part of documentation. It describes software
  or firmware specific usage and not relevant for HW description.
- DT: use <soc>-mu instead of <soc>-mu-<mu side> and add fsl,mu-side-a
  parameter.
- DT: add most of know i.MX variants with MU
- imx-mailbox: use macros instead of precalculated bit index.
- imx-mailbox: remove warning message for clk.
- imx-mailbox: use imx_mu_chan[%idx] for devm_request_irq.
- imx-mailbox: depend on ARCH_MXC instead of SOX_IMX7

20180615 changes v2:
- DT: use mailbox@ instead of mu@
- DT: change interrupts description
- clk: use imx_clk_gate4 instead of imx_clk_gate2
- imx-mailbox: remove last_tx_done support
- imx-mailbox: fix module description 

This patches are providing support for mailbox (Messaging Unit)
for i.MX7D.
Functionality was tested on PHYTEC phyBOARD-Zeta i.MX7D with
Linux running on all cores: ARM Cortex-A7 and ARM Cortex-M4.

Both parts of i.MX messaging Unit are visible for all CPUs available
on i.MX7D. Communication worked independent of MU side in combination
with CPU. For example MU-A used on ARM Cortex-A7 and MU-B used on ARM Cortex-M4
or other ways around.

Dong Aisheng (1):
  dt-bindings: arm: fsl: add mu binding doc

Oleksij Rempel (3):
  dt-bindings: arm: fsl: rework mu doc
  ARM: dts: imx7s: add i.MX7 messaging unit support
  mailbox: Add support for i.MX7D messaging unit

 .../devicetree/bindings/mailbox/fsl,mu.txt    |  32 ++
 arch/arm/boot/dts/imx7s.dtsi                  |  19 ++
 drivers/mailbox/Kconfig                       |   6 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/imx-mailbox.c                 | 300 ++++++++++++++++++
 5 files changed, 359 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 create mode 100644 drivers/mailbox/imx-mailbox.c

-- 
2.18.0
