From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Aug 2015 17:07:07 -0700
Subject: [GIT PULL 4/7] ARM: SoC driver updates for v4.3
In-Reply-To: <1441066030-23225-1-git-send-email-olof@lixom.net>
References: <1441066030-23225-1-git-send-email-olof@lixom.net>
Message-ID: <1441066030-23225-5-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some releases this branch is nearly empty, others we have more stuff. It
tends to gather drivers that need SoC modification or dependencies such
that they have to (also) go in through our tree.

For this release, we have merged in part of the reset controller tree
(with handshake that the parts we have merged in will remain stable),
as well as dependencies on a few clock branches.

In general, new items here are:

- Qualcomm driver for SMM/SMD, which is how they communicate with the
coprocessors on (some) of their platforms
- Memory controller work for ARM's PL172 memory controller
- Reset drivers for various platforms
- PMU power domain support for Marvell platforms
- Tegra support for T132/T210 SoCs: PMC, fuse, memory controller per-SoC support

----------------------------------------------------------------

The following changes since commit 995140c8ab9423d63f23f106815550801c93e599:

  Merge branch 'next/soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to 21815b9a24c6e6d3488703609561bd2892d3d9f3:

  Merge tag 'tegra-for-4.3-memory' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into next/drivers

----------------------------------------------------------------

Alban Bedel (3):
      devicetree: Add bindings for the ATH79 reset controller
      reset: Add a driver for the reset controller on the AR71XX/AR9XXX
      MIPS: ath79: Add the reset controller to the AR9132 dtsi

Bjorn Andersson (5):
      soc: qcom: Add Shared Memory Manager driver
      soc: qcom: Add device tree binding for Shared Memory Device
      soc: qcom: Add Shared Memory Driver
      soc: qcom: Driver for the Qualcomm RPM over SMD
      devicetree: soc: Add Qualcomm SMD based RPM DT binding

Dinh Nguyen (1):
      reset: socfpga: Update reset-socfpga to read the altr,modrst-offset property

Fabian Frederick (1):
      reset: sti: constify of_device_id array

Geert Uytterhoeven (5):
      clk: shmobile: Add CPG/MSTP Clock Domain support
      clk: shmobile: r8a7778: Add CPG/MSTP Clock Domain support
      clk: shmobile: r8a7779: Add CPG/MSTP Clock Domain support
      clk: shmobile: rcar-gen2: Add CPG/MSTP Clock Domain support
      clk: shmobile: rz: Add CPG/MSTP Clock Domain support

Joachim Eastwood (5):
      memory: add ARM PL172 MultiPort Memory Controller driver
      doc: dt: add documentation for pl172 memory bindings
      memory: pl172: fix modular build
      reset: add driver for lpc18xx rgu
      doc: dt: add documentation for lpc1850-rgu reset driver

Lina Iyer (1):
      drivers: qcom: Select QCOM_SCM unconditionally for QCOM_PM

Masahiro Yamada (1):
      soc: tegra: Remove redundant $(CONFIG_ARCH_TEGRA) in Makefile

Moritz Fischer (2):
      docs: dts: Added documentation for Xilinx Zynq Reset Controller bindings.
      reset: reset-zynq: Adding support for Xilinx Zynq reset controller.

Olof Johansson (7):
      Merge tag 'mvebu-soc-4.3-2' of git://git.infradead.org/linux-mvebu into next/drivers
      Merge tag 'qcom-soc-for-4.3' of git://codeaurora.org/quic/kernel/agross-msm into next/drivers
      Merge tag 'renesas-clk-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'reset-for-4.3' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'tegra-for-4.3-soc' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.3-cpufreq' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.3-memory' of git://git.kernel.org/.../tegra/linux into next/drivers

Paul Walmsley (1):
      memory: tegra: Add support for a variable-size client ID bitfield

Philipp Zabel (3):
      MAINTAINERS: add include/dt-bindings/reset path to reset controller entry
      ARM: STi: DT: Move reset controller constants into common location
      Merge branch 'reset/ath79' into reset/next

Russell King (1):
      ARM: dove: create a proper PMU driver for power domains, PMU IRQs and resets

Thierry Reding (17):
      soc/tegra: Add Tegra132 support
      soc/tegra: Add Tegra210 support
      memory: tegra: Expose supported rates via debugfs
      soc/tegra: pmc: Avoid usage of uninitialized variable
      soc/tegra: pmc: Restrict legacy code to 32-bit ARM
      soc/tegra: pmc: Add Tegra210 support
      soc/tegra: fuse: Restrict legacy code to 32-bit ARM
      soc/tegra: fuse: Unify Tegra20 and Tegra30 drivers
      soc/tegra: fuse: Add Tegra210 support
      soc/tegra: fuse: Rename core_* to soc_*
      soc/tegra: fuse: Add spare bit offset for Tegra114
      soc/tegra: fuse: Add spare bit offset for Tegra124
      soc/tegra: fuse: Add spare bit offset for Tegra210
      memory: tegra: Add Tegra210 support
      soc/tegra: pmc: Remove unnecessary return statement
      soc/tegra: pmc: Use existing pclk reference
      ARM: tegra: Disable cpuidle if PSCI is available

Tomeu Vizoso (1):
      ARM: tegra: cpuidle: implement cpuidle_state.enter_freeze()

Tuomas Tynkkynen (3):
      cpufreq: tegra124: Add device tree bindings
      cpufreq: tegra: Rename tegra-cpufreq to tegra20-cpufreq
      cpufreq: Add cpufreq driver for Tegra124


 .../clock/renesas,r8a7778-cpg-clocks.txt        |   29 +-
 .../clock/renesas,r8a7779-cpg-clocks.txt        |   30 +-
 .../clock/renesas,rcar-gen2-cpg-clocks.txt      |   26 +-
 .../bindings/clock/renesas,rz-cpg-clocks.txt    |   29 +-
 .../bindings/cpufreq/tegra124-cpufreq.txt       |   44 +
 .../bindings/memory-controllers/arm,pl172.txt   |  125 ++
 .../devicetree/bindings/reset/ath79-reset.txt   |   20 +
 .../bindings/reset/nxp,lpc1850-rgu.txt          |   84 ++
 .../bindings/reset/st,sti-picophyreset.txt      |    2 +-
 .../bindings/reset/st,sti-powerdown.txt         |    4 +-
 .../bindings/reset/st,sti-softreset.txt         |    4 +-
 .../devicetree/bindings/reset/zynq-reset.txt    |   68 +
 .../devicetree/bindings/soc/qcom,smd-rpm.txt    |  117 ++
 .../devicetree/bindings/soc/qcom/qcom,smd.txt   |   79 ++
 MAINTAINERS                                     |    1 +
 arch/arm/boot/dts/stih407-family.dtsi           |    2 +-
 arch/arm/boot/dts/stih415.dtsi                  |    2 +-
 arch/arm/boot/dts/stih416.dtsi                  |    2 +-
 arch/arm/mach-mvebu/Kconfig                     |    1 +
 arch/arm/mach-mvebu/dove.c                      |    2 +
 arch/arm/mach-shmobile/Kconfig                  |    2 +
 arch/arm/mach-tegra/cpuidle-tegra114.c          |   19 +-
 arch/arm/mach-tegra/iomap.h                     |    3 -
 arch/mips/Kconfig                               |    1 +
 arch/mips/boot/dts/qca/ar9132.dtsi              |    8 +
 drivers/clk/shmobile/clk-mstp.c                 |   87 ++
 drivers/clk/shmobile/clk-r8a7778.c              |    2 +
 drivers/clk/shmobile/clk-r8a7779.c              |    2 +
 drivers/clk/shmobile/clk-rcar-gen2.c            |    2 +
 drivers/clk/shmobile/clk-rz.c                   |    3 +
 drivers/cpufreq/Kconfig.arm                     |   13 +-
 drivers/cpufreq/Makefile                        |    3 +-
 drivers/cpufreq/tegra124-cpufreq.c              |  214 +++
 .../{tegra-cpufreq.c => tegra20-cpufreq.c}      |    0
 drivers/iommu/Kconfig                           |    2 +-
 drivers/memory/Kconfig                          |    8 +
 drivers/memory/Makefile                         |    1 +
 drivers/memory/pl172.c                          |  301 ++++
 drivers/memory/tegra/Makefile                   |    1 +
 drivers/memory/tegra/mc.c                       |    8 +-
 drivers/memory/tegra/mc.h                       |    4 +
 drivers/memory/tegra/tegra114.c                 |    1 +
 drivers/memory/tegra/tegra124-emc.c             |   42 +-
 drivers/memory/tegra/tegra124.c                 |    2 +
 drivers/memory/tegra/tegra210.c                 | 1080 ++++++++++++++
 drivers/memory/tegra/tegra30.c                  |    1 +
 drivers/reset/Makefile                          |    3 +
 drivers/reset/reset-ath79.c                     |  128 ++
 drivers/reset/reset-lpc18xx.c                   |  258 ++++
 drivers/reset/reset-socfpga.c                   |   19 +-
 drivers/reset/reset-zynq.c                      |  155 ++
 drivers/reset/sti/reset-stih407.c               |    4 +-
 drivers/reset/sti/reset-stih415.c               |    4 +-
 drivers/reset/sti/reset-stih416.c               |    4 +-
 drivers/soc/Makefile                            |    1 +
 drivers/soc/dove/Makefile                       |    1 +
 drivers/soc/dove/pmu.c                          |  412 ++++++
 drivers/soc/qcom/Kconfig                        |   31 +
 drivers/soc/qcom/Makefile                       |    3 +
 drivers/soc/qcom/smd-rpm.c                      |  244 ++++
 drivers/soc/qcom/smd.c                          | 1319 ++++++++++++++++++
 drivers/soc/qcom/smem.c                         |  775 ++++++++++
 drivers/soc/tegra/Makefile                      |    6 +-
 drivers/soc/tegra/common.c                      |    2 +
 drivers/soc/tegra/fuse/Makefile                 |    2 +
 drivers/soc/tegra/fuse/fuse-tegra.c             |  257 +++-
 drivers/soc/tegra/fuse/fuse-tegra20.c           |  175 +--
 drivers/soc/tegra/fuse/fuse-tegra30.c           |  232 ++-
 drivers/soc/tegra/fuse/fuse.h                   |   95 +-
 drivers/soc/tegra/fuse/speedo-tegra114.c        |   22 +-
 drivers/soc/tegra/fuse/speedo-tegra124.c        |   26 +-
 drivers/soc/tegra/fuse/speedo-tegra20.c         |   28 +-
 drivers/soc/tegra/fuse/speedo-tegra210.c        |  184 +++
 drivers/soc/tegra/fuse/speedo-tegra30.c         |   48 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c          |   76 +-
 drivers/soc/tegra/pmc.c                         |  125 +-
 include/dt-bindings/memory/tegra210-mc.h        |   36 +
 .../stih407-resets.h                            |    0
 .../stih415-resets.h                            |    0
 .../stih416-resets.h                            |    0
 include/linux/clk/shmobile.h                    |   12 +
 include/linux/soc/dove/pmu.h                    |    6 +
 include/linux/soc/qcom/smd-rpm.h                |   35 +
 include/linux/soc/qcom/smd.h                    |   46 +
 include/linux/soc/qcom/smem.h                   |   11 +
 include/soc/tegra/fuse.h                        |    6 +-
 include/soc/tegra/mc.h                          |    2 +
 include/soc/tegra/pmc.h                         |    5 +
 88 files changed, 6781 insertions(+), 498 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/tegra124-cpufreq.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt
 create mode 100644 Documentation/devicetree/bindings/reset/ath79-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt
 create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
 create mode 100644 drivers/cpufreq/tegra124-cpufreq.c
 rename drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} (100%)
 create mode 100644 drivers/memory/pl172.c
 create mode 100644 drivers/memory/tegra/tegra210.c
 create mode 100644 drivers/reset/reset-ath79.c
 create mode 100644 drivers/reset/reset-lpc18xx.c
 create mode 100644 drivers/reset/reset-zynq.c
 create mode 100644 drivers/soc/dove/Makefile
 create mode 100644 drivers/soc/dove/pmu.c
 create mode 100644 drivers/soc/qcom/smd-rpm.c
 create mode 100644 drivers/soc/qcom/smd.c
 create mode 100644 drivers/soc/qcom/smem.c
 create mode 100644 drivers/soc/tegra/fuse/speedo-tegra210.c
 create mode 100644 include/dt-bindings/memory/tegra210-mc.h
 rename include/dt-bindings/{reset-controller => reset}/stih407-resets.h (100%)
 rename include/dt-bindings/{reset-controller => reset}/stih415-resets.h (100%)
 rename include/dt-bindings/{reset-controller => reset}/stih416-resets.h (100%)
 create mode 100644 include/linux/soc/dove/pmu.h
 create mode 100644 include/linux/soc/qcom/smd-rpm.h
 create mode 100644 include/linux/soc/qcom/smd.h
 create mode 100644 include/linux/soc/qcom/smem.h
