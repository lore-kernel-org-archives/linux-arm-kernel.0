From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 00:26:08 +0200
Subject: [GIT PULL 7/7] ARM: SoC driver updates for v4.7
In-Reply-To: <8749147.ztcb6kVhye@wuerfel>
References: <8749147.ztcb6kVhye@wuerfel>
Message-ID: <2633732.4xlcotETON@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to 5420f9fd159761b88978c312c3b350546f8615bb:

  arm-ccn: Enable building as module (2016-05-09 16:36:03 +0200)

----------------------------------------------------------------
ARM: SoC driver updates for v4.7

Driver updates for ARM SoCs, these contain various things that touch
the drivers/ directory but got merged through arm-soc for practical
reasons. For the most part, this is now related to power management
controllers, which have not yet been abstracted into a separate
subsystem, and typically require some code in drivers/soc or arch/arm
to control the power domains.

Another large chunk here is a rework of the NVIDIA Tegra USB3.0
support, which was surprisingly tricky and took a long time to
get done.

Finally, reset controller handling as always gets merged through here
as well.

----------------------------------------------------------------
Andrew Bresticker (1):
      clk: tegra: Add interface to enable hardware control of SATA/XUSB PLLs

Andy Gross (1):
      Merge tag 'qcom-soc-for-4.7' into soc-for-4.7-p2

Arnd Bergmann (16):
      Merge tag 'versatile-flash-for-arm-soc' of git://git.kernel.org/.../linusw/linux-integrator into next/drivers
      Merge tag 'tegra-for-4.7-soc' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'arm-soc/for-4.7/drivers' of http://github.com/Broadcom/stblinux into next/drivers
      Merge tag 'qcom-soc-for-4.7-2' of git://git.kernel.org/.../agross/linux into next/drivers
      soc: brcmstb: select SOC_BUS
      physmap_of: ensure versatile code is reachable
      drivers: firmware: psci: make two helper functions inline
      Merge tag 'renesas-rcar-sysc2-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'samsung-drivers-exynos-srom-4.7' of git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'v4.7-rockchip-drivers-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'tegra-for-4.7-phy' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.7-pci' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.7-xhci' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.7-genpd' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'v4.6-next-soc' of https://github.com/mbgg/linux-mediatek into next/drivers
      Merge tag 'reset-for-4.7-2' of git://git.pengutronix.de/git/pza/linux into next/drivers

Bjorn Andersson (8):
      soc: qcom: smem_state: Add stubs for disabled smem_state
      soc: qcom: smd: Introduce callback setter
      soc: qcom: smd: Split discovery and state change work
      soc: qcom: smd: Refactor channel open and close handling
      soc: qcom: smd: Support multiple channels per sdev
      soc: qcom: smd: Support opening additional channels
      soc: qcom: smem: Use write-combine remap for SMEM
      soc: qcom: smd: Make callback pass channel reference

Daniel Lezcano (1):
      reset: Add missing function stub for device_reset

Elaine Zhang (8):
      soc: rockchip: power-domain: make idle handling optional
      soc: rockchip: power-domain: allow domains only handling idle requests
      soc: rockchip: power-domain: add support for sub-power domains
      dt-bindings: add power-domain header for RK3399 SoCs
      dt-bindings: add binding for rk3399 power domains
      soc: rockchip: power-domain: Modify power domain driver for rk3399
      dt-bindings: modify document of Rockchip power domains
      soc: rockchip: power-domain: support qos save and restore

Florian Fainelli (2):
      bus: brcmstb_gisb: Rework dependencies
      soc: brcmstb: Unmap sun_top_ctrl_base on errors

Geert Uytterhoeven (24):
      clk: renesas: mstp: Drop check for CONFIG_PM_GENERIC_DOMAINS_OF
      clk: renesas: cpg-mssr: Drop check for CONFIG_PM_GENERIC_DOMAINS_OF
      clk: renesas: mstp: Clarify cpg_mstp_{at,de}tach_dev() domain parameter
      PM / Domains: Add DT bindings for the R-Car System Controller
      soc: renesas: Add r8a7779 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7790 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7791 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7793 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7794 SYSC PM Domain Binding Definitions
      soc: renesas: Add r8a7795 SYSC PM Domain Binding Definitions
      clk: renesas: Provide Kconfig symbols for CPG/MSSR and CPG/MSTP support
      clk: renesas: mstp: Provide dummy attach/detach_dev callbacks
      clk: renesas: cpg-mssr: Export cpg_mssr_{at,de}tach_dev()
      soc: renesas: Move pm-rcar to drivers/soc/renesas/rcar-sysc
      soc: renesas: rcar-sysc: Improve rcar_sysc_power() debug info
      soc: renesas: rcar-sysc: Add DT support for SYSC PM domains
      soc: renesas: rcar-sysc: Make rcar_sysc_power_is_off() static
      soc: renesas: rcar-sysc: Enable Clock Domain for I/O devices
      soc: renesas: rcar-sysc: Add support for R-Car H1 power areas
      soc: renesas: rcar-sysc: Add support for R-Car H2 power areas
      soc: renesas: rcar-sysc: Add support for R-Car M2-W power areas
      soc: renesas: rcar-sysc: Add support for R-Car M2-N power areas
      soc: renesas: rcar-sysc: Add support for R-Car E2 power areas
      soc: renesas: rcar-sysc: Add support for R-Car H3 power areas

Hans de Goede (3):
      reset: Make [of_]reset_control_get[_foo] functions wrappers
      reset: Share struct reset_control between reset_control_get calls
      reset: Add support for shared reset controls

Heiko Stuebner (1):
      Merge branch 'v4.7-shared/pdids' into v4.7-armsoc/drivers

Jisheng Zhang (2):
      drivers: firmware: psci: drop duplicate const from psci_of_match
      drivers: firmware: psci: make two helper functions static

Joachim Eastwood (1):
      reset: lpc18xx: get rid of global variables for restart notifier

John Crispin (11):
      soc: mediatek: PMIC wrap: don't duplicate the wrapper data
      soc: mediatek: PMIC wrap: add wrapper callbacks for init_reg_clock
      soc: mediatek: PMIC wrap: split SoC specific init into callback
      soc: mediatek: PMIC wrap: WRAP_INT_EN needs a different bitmask for MT2701/7623
      soc: mediatek: PMIC wrap: SPI_WRITE needs a different bitmask for MT2701/7623
      soc: mediatek: PMIC wrap: move wdt_src into the pmic_wrapper_type struct
      soc: mediatek: PMIC wrap: remove pwrap_is_mt8135() and pwrap_is_mt8173()
      soc: mediatek: PMIC wrap: add a slave specific struct
      soc: mediatek: PMIC wrap: add mt6323 slave support
      soc: mediatek: PMIC wrap: add MT2701/7623 support
      ARM: mediatek: enable gpt6 on boot up to make arch timer work on mt7623

Jon Hunter (16):
      soc/tegra: pmc: Add missing structure members to kernel-doc
      soc/tegra: pmc: Fix sparse warning for tegra_pmc_init_tsense_reset()
      soc/tegra: pmc: Remove debugfs entry on probe failure
      soc/tegra: pmc: Remove non-existing power partitions for Tegra210
      soc/tegra: pmc: Remove non-existing L2 partition for Tegra124
      soc/tegra: pmc: Restore base address on probe failure
      soc/tegra: pmc: Protect public functions from potential race conditions
      soc/tegra: pmc: Change powergate and rail IDs to be an unsigned type
      soc/tegra: pmc: Fix testing of powergate state
      soc/tegra: pmc: Fix verification of valid partitions
      soc/tegra: pmc: Remove additional check for a valid partition
      soc/tegra: pmc: Ensure GPU partition can be toggled on/off by PMC
      soc/tegra: pmc: Wait for powergate state to change
      dt-bindings: Update NVIDIA PMC for Tegra
      dt-bindings: Add power domain info for NVIDIA PMC
      soc/tegra: pmc: Add generic PM domain support

Justin Chen (1):
      soc: brcmstb: add SoC driver to brcmstb

Krzysztof Kozlowski (1):
      Merge tag 'samsung-dt-exynos-srom-fixup-4.7' into for-v4.7/drivers-memory-exynos-srom

Lina Iyer (1):
      drivers: qcom: spm: avoid module usage in non-modular SPM driver

Linus Walleij (4):
      mtd: physmap_of: add a hook for Versatile write protection
      mtd: augment the "arm,versatile-flash" bindings
      ARM: versatile: move flash registration to the device tree
      ARM: integrator: move flash registration to device tree

Neil Armstrong (2):
      reset: Add Oxford Semiconductor Reset Controller driver
      dt-bindings: Add Oxford Semiconductor Reset Controller bindings

Olof Johansson (4):
      Merge tag 'qcom-soc-for-4.7' of git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'reset-for-4.7' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'renesas-simple-pm-bus-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'v4.7-rockchip-drivers-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers

Pankaj Dubey (5):
      ARM: dts: change SROM node compatible from generic to model specific
      dt-bindings: EXYNOS: Add exynos-srom device tree binding
      memory: Add support for Exynos SROM driver
      MAINTAINERS: Add maintainers entry for drivers/memory/samsung
      ARM: EXYNOS: Remove SROM related register settings from mach-exynos

Pavel Fedin (1):
      memory: samsung: exynos-srom: Add support for bank configuration

Shawn Lin (1):
      soc: rockchip: power-domain: check the existing of regmap

Simon Horman (2):
      bus: simple-pm-bus: Use ARCH_RENESAS
      Merge tag 'clk-renesas-for-v4.7-tag2' of git://git.kernel.org/.../geert/renesas-drivers into rcar-sysc-for-v4.7

Srinivas Kandagatla (2):
      MAINTAINERS: add qcom i2c and spi drivers to list
      MAINTAINERS: add qcom clocks to the maintainers list

Suzuki K Poulose (1):
      arm-ccn: Enable building as module

Thierry Reding (15):
      Merge branch 'for-4.7/soc' into for-4.7/genpd
      Merge branch 'for-4.7/clk' into for-4.7/phy
      phy: core: Allow children node to be overridden
      dt-bindings: phy: Add NVIDIA Tegra XUSB pad controller binding
      dt-bindings: phy: tegra-xusb-padctl: Add Tegra210 support
      phy: Add Tegra XUSB pad controller support
      phy: tegra: Add Tegra210 support
      Merge branch 'for-4.7/phy' into for-4.7/pci
      dt-bindings: pci: tegra: Update for per-lane PHYs
      PCI: tegra: Support per-lane PHYs
      Merge branch 'for-4.7/phy' into for-4.7/xhci
      dt-bindings: usb: Add NVIDIA Tegra XUSB controller binding
      dt-bindings: usb: xhci-tegra: Add Tegra210 XUSB controller support
      usb: xhci: Add NVIDIA Tegra XUSB controller driver
      usb: xhci: tegra: Add Tegra210 support

Ulrich Hecht (1):
      clk: renesas: r8a7795: add PWM clock

Wolfram Sang (5):
      clk: renesas: r8a7795: make SD clk definition specific for GEN3
      clk: renesas: cpg-mssr: add generic support for read-only DIV6 clocks
      clk: renesas: r8a7795: add OSC and RINT clocks
      clk: renesas: r8a7795: add R clk
      clk: renesas: r8a7795: add RWDT clock

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |   92 +-
 .../bindings/memory-controllers/exynos-srom.txt    |   79 +
 .../devicetree/bindings/mtd/arm-versatile.txt      |   20 +-
 .../bindings/pci/nvidia,tegra20-pcie.txt           |  224 ++-
 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |  733 +++++++
 .../pinctrl/nvidia,tegra124-xusb-padctl.txt        |    6 +
 .../bindings/power/renesas,rcar-sysc.txt           |   48 +
 .../devicetree/bindings/reset/oxnas,reset.txt      |   58 +
 .../bindings/soc/rockchip/power_domain.txt         |   47 +
 .../bindings/usb/nvidia,tegra124-xusb.txt          |  120 ++
 Documentation/phy.txt                              |   16 +-
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/exynos4.dtsi                     |    4 +-
 arch/arm/boot/dts/exynos5.dtsi                     |    4 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |    2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |    4 +-
 arch/arm/boot/dts/integrator.dtsi                  |    3 +-
 arch/arm/boot/dts/versatile-ab.dts                 |    5 +-
 arch/arm/mach-bcm/Kconfig                          |    2 +-
 arch/arm/mach-exynos/Kconfig                       |    3 +
 arch/arm/mach-exynos/exynos.c                      |   17 -
 arch/arm/mach-exynos/include/mach/map.h            |    3 -
 arch/arm/mach-exynos/regs-srom.h                   |   53 -
 arch/arm/mach-exynos/suspend.c                     |   20 +-
 arch/arm/mach-integrator/integrator_ap.c           |   62 -
 arch/arm/mach-integrator/integrator_cp.c           |   51 -
 arch/arm/mach-mediatek/mediatek.c                  |    1 +
 arch/arm/mach-shmobile/Kconfig                     |   11 +-
 arch/arm/mach-shmobile/Makefile                    |    1 -
 arch/arm/mach-shmobile/pm-r8a7779.c                |    3 +-
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |    2 +-
 arch/arm/mach-shmobile/pm-rcar.c                   |  164 --
 arch/arm/mach-shmobile/smp-r8a7779.c               |    2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c               |    2 +-
 arch/arm/mach-tegra/platsmp.c                      |   16 +-
 arch/arm/mach-versatile/versatile_dt.c             |   47 -
 arch/arm/plat-samsung/include/plat/map-s5p.h       |    1 -
 drivers/bus/Kconfig                                |    5 +-
 drivers/bus/arm-ccn.c                              |    7 +-
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/renesas/Kconfig                        |   16 +
 drivers/clk/renesas/Makefile                       |   26 +-
 drivers/clk/renesas/clk-mstp.c                     |    7 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |   34 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |   47 +-
 drivers/clk/renesas/renesas-cpg-mssr.h             |    6 +-
 drivers/clk/tegra/clk-tegra210.c                   |   58 +
 drivers/firmware/psci.c                            |    6 +-
 drivers/gpu/drm/tegra/drm.h                        |    2 +-
 drivers/memory/Kconfig                             |    1 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/samsung/Kconfig                     |   13 +
 drivers/memory/samsung/Makefile                    |    1 +
 drivers/memory/samsung/exynos-srom.c               |  231 +++
 drivers/memory/samsung/exynos-srom.h               |   51 +
 drivers/mtd/maps/Kconfig                           |   10 +
 drivers/mtd/maps/Makefile                          |    3 +
 drivers/mtd/maps/physmap_of.c                      |    6 +
 drivers/mtd/maps/physmap_of_versatile.c            |  255 +++
 drivers/mtd/maps/physmap_of_versatile.h            |   16 +
 drivers/pci/host/pci-tegra.c                       |  244 ++-
 drivers/phy/Kconfig                                |    2 +
 drivers/phy/Makefile                               |    2 +
 drivers/phy/phy-core.c                             |   50 +-
 drivers/phy/tegra/Kconfig                          |    8 +
 drivers/phy/tegra/Makefile                         |    6 +
 drivers/phy/tegra/xusb-tegra124.c                  | 1752 +++++++++++++++++
 drivers/phy/tegra/xusb-tegra210.c                  | 2045 ++++++++++++++++++++
 drivers/phy/tegra/xusb.c                           | 1021 ++++++++++
 drivers/phy/tegra/xusb.h                           |  421 ++++
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |   20 +-
 drivers/reset/Kconfig                              |    3 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/core.c                               |  217 ++-
 drivers/reset/reset-lpc18xx.c                      |   22 +-
 drivers/reset/reset-oxnas.c                        |  136 ++
 drivers/soc/Makefile                               |    3 +-
 drivers/soc/brcmstb/Kconfig                        |    1 +
 drivers/soc/brcmstb/common.c                       |   66 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               |  544 ++++--
 drivers/soc/qcom/smd-rpm.c                         |    9 +-
 drivers/soc/qcom/smd.c                             |  247 ++-
 drivers/soc/qcom/smem.c                            |    3 +-
 drivers/soc/qcom/spm.c                             |    8 +-
 drivers/soc/qcom/wcnss_ctrl.c                      |    8 +-
 drivers/soc/renesas/Makefile                       |    7 +
 drivers/soc/renesas/r8a7779-sysc.c                 |   34 +
 drivers/soc/renesas/r8a7790-sysc.c                 |   48 +
 drivers/soc/renesas/r8a7791-sysc.c                 |   33 +
 drivers/soc/renesas/r8a7794-sysc.c                 |   33 +
 drivers/soc/renesas/r8a7795-sysc.c                 |   56 +
 drivers/soc/renesas/rcar-sysc.c                    |  401 ++++
 drivers/soc/renesas/rcar-sysc.h                    |   58 +
 drivers/soc/rockchip/pm_domains.c                  |  247 ++-
 drivers/soc/tegra/pmc.c                            |  613 +++++-
 drivers/usb/host/Kconfig                           |    9 +
 drivers/usb/host/Makefile                          |    1 +
 drivers/usb/host/xhci-tegra.c                      | 1331 +++++++++++++
 include/dt-bindings/power/r8a7779-sysc.h           |   27 +
 include/dt-bindings/power/r8a7790-sysc.h           |   34 +
 include/dt-bindings/power/r8a7791-sysc.h           |   26 +
 include/dt-bindings/power/r8a7793-sysc.h           |   28 +
 include/dt-bindings/power/r8a7794-sysc.h           |   26 +
 include/dt-bindings/power/r8a7795-sysc.h           |   42 +
 include/dt-bindings/power/rk3399-power.h           |   53 +
 include/linux/clk/renesas.h                        |   16 +-
 include/linux/clk/tegra.h                          |    5 +
 include/linux/phy/phy.h                            |   31 +-
 include/linux/phy/tegra/xusb.h                     |   30 +
 include/linux/psci.h                               |    2 -
 include/linux/reset-controller.h                   |    2 +
 include/linux/reset.h                              |  194 +-
 include/linux/soc/qcom/smd.h                       |   11 +-
 include/linux/soc/qcom/smem_state.h                |   35 +
 .../linux/soc/renesas/rcar-sysc.h                  |    9 +-
 include/soc/tegra/fuse.h                           |    1 +
 include/soc/tegra/pmc.h                            |   36 +-
 117 files changed, 11999 insertions(+), 1056 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
 create mode 100644 Documentation/devicetree/bindings/reset/oxnas,reset.txt
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
 delete mode 100644 arch/arm/mach-exynos/regs-srom.h
 delete mode 100644 arch/arm/mach-shmobile/pm-rcar.c
 create mode 100644 drivers/clk/renesas/Kconfig
 create mode 100644 drivers/memory/samsung/Kconfig
 create mode 100644 drivers/memory/samsung/Makefile
 create mode 100644 drivers/memory/samsung/exynos-srom.c
 create mode 100644 drivers/memory/samsung/exynos-srom.h
 create mode 100644 drivers/mtd/maps/physmap_of_versatile.c
 create mode 100644 drivers/mtd/maps/physmap_of_versatile.h
 create mode 100644 drivers/phy/tegra/Kconfig
 create mode 100644 drivers/phy/tegra/Makefile
 create mode 100644 drivers/phy/tegra/xusb-tegra124.c
 create mode 100644 drivers/phy/tegra/xusb-tegra210.c
 create mode 100644 drivers/phy/tegra/xusb.c
 create mode 100644 drivers/phy/tegra/xusb.h
 create mode 100644 drivers/reset/reset-oxnas.c
 create mode 100644 drivers/soc/renesas/Makefile
 create mode 100644 drivers/soc/renesas/r8a7779-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7790-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7791-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7794-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7795-sysc.c
 create mode 100644 drivers/soc/renesas/rcar-sysc.c
 create mode 100644 drivers/soc/renesas/rcar-sysc.h
 create mode 100644 drivers/usb/host/xhci-tegra.c
 create mode 100644 include/dt-bindings/power/r8a7779-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7790-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7791-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7793-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7794-sysc.h
 create mode 100644 include/dt-bindings/power/r8a7795-sysc.h
 create mode 100644 include/dt-bindings/power/rk3399-power.h
 create mode 100644 include/linux/phy/tegra/xusb.h
 rename arch/arm/mach-shmobile/pm-rcar.h => include/linux/soc/renesas/rcar-sysc.h (60%)
