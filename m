From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Mar 2015 22:02:26 +0800
Subject: [GIT PULL 2/4] ARM: imx: soc changes for 4.1
Message-ID: <CAAQ0ZWT+-s9V6GtYAQKoF0Qk8XZctSnSemkvqR6twD0Nxo+KTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
tags/imx-soc-4.1

for you to fetch changes up to ae4aee959f7959427e99edb3927c9512986cbdc5:

  ARM: imx: depend MXC debug board on 3DS machines (2015-03-13 21:55:29 +0800)

----------------------------------------------------------------
The i.MX SoC changes for 4.1:
 - An error handling improvement on imx-weim bus driver
 - A number of imx6q clock tree update around MIPI support
 - Add support for i.MX6 GPU/VPU power domain
 - Enable SMP_ON_UP build for Vybrid
 - Let MXC_DEBUG_BOARD depend on 3-stack (3DS) boards

----------------------------------------------------------------
Alison Chaiken (1):
      bus: imx-weim: improve error handling upon child probe-failure

Liu Ying (6):
      ARM: imx6q: Add GPR3 MIPI muxing control register field shift
bits definition
      ARM: imx6q: clk: Add the video_27m clock
      ARM: imx6q: clk: Change hdmi_isfr clock's parent to be video_27m clock
      ARM: imx6q: clk: Change hsi_tx clock to be a shared clock gate
      ARM: imx6q: clk: Add support for mipi_core_cfg clock as a shared
clock gate
      ARM: imx6q: clk: Add support for mipi_ipg clock as a shared clock gate

Philipp Zabel (2):
      Documentation: Add device tree bindings for Freescale i.MX GPC
      ARM: imx6: gpc: Add PU power domain for GPU/VPU

Stefan Agner (2):
      ARM: vf610: use SMP_ON_UP for Vybrid SoC
      ARM: imx: depend MXC debug board on 3DS machines

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  59 ++++++
 arch/arm/mach-imx/Kconfig                          |   3 +
 arch/arm/mach-imx/clk-imx6q.c                      |   8 +-
 arch/arm/mach-imx/gpc.c                            | 213 +++++++++++++++++++++
 drivers/bus/imx-weim.c                             |  13 +-
 include/dt-bindings/clock/imx6qdl-clock.h          |   5 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   1 +
 7 files changed, 293 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
