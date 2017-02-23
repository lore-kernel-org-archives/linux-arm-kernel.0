From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2017 00:11:48 +0100
Subject: [GIT PULL 7/7] ARM: SoC driver updates
In-Reply-To: <8729461.VkrRdW7LzJ@wuerfel>
References: <8729461.VkrRdW7LzJ@wuerfel>
Message-ID: <7385881.DYWctooIcO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to db27dd05b1da6e658494a2570680f8d0ddbc578c:

  Merge tag 'davinci-for-v4.11/drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci into next/drivers (2017-02-16 17:14:07 +0100)

----------------------------------------------------------------
ARM: SoC driver updates

Driver updates for ARM SoCs.

A handful of driver changes this time around. The larger changes are:

 - Reset drivers for hi3660 and zx2967
 - AHCI driver for Davinci, acked by Tejun and brought in here due to
   platform dependencies
 - Cleanups of atmel-ebi (External Bus Interface)
 - Tweaks for Rockchip GRF (General Register File) usage (kitchensink misc
   register range on the SoCs)
 - PM domains changes for support of two new ZTE SoCs (zx296718 and zx2967)

----------------------------------------------------------------
Andy Gross (2):
      firmware: qcom: scm: Mask APQ8064 core clk dependency
      firmware: qcom_scm: Add set remote state API

Arnd Bergmann (4):
      Merge tag 'reset-for-4.11-2' of git://git.pengutronix.de/pza/linux into next/drivers
      Merge tag 'samsung-drivers-soc-pm-domains-4.11' of git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'samsung-drivers-soc-pmu-4.11-3' of git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'davinci-for-v4.11/drivers' of git://git.kernel.org/.../nsekhar/linux-davinci into next/drivers

Baoyou Xie (8):
      dt-bindings: zte: add bindings document for zx2967 power domain controller
      MAINTAINERS: add zx2967 SoC drivers to ARM ZTE architecture
      soc: zte: Add header for PM domains specifiers
      soc: zte: pm_domains: Prepare for supporting ARMv8 zx2967 family
      soc: zte: pm_domains: Add support for zx296718
      dt: bindings: add documentation for zx2967 family reset controller
      MAINTAINERS: add zx2967 reset controller driver to ARM ZTE architecture
      reset: zx2967: add reset controller driver for ZTE's zx2967 family

Bartosz Golaszewski (6):
      sata: ahci-da850: get the sata clock using a connection id
      sata: ahci-da850: add device tree match table
      sata: ahci-da850: implement a workaround for the softreset quirk
      sata: ahci: export ahci_do_hardreset() locally
      sata: ahci-da850: add a workaround for controller instability
      sata: ahci-da850: un-hardcode the MPY bits

Bhumika Goyal (1):
      reset: constify reset_control_ops structures

Boris Brezillon (4):
      memory/atmel-ebi: Fix ns <-> cycles conversions
      memory: atmel-ebi: Fix the test to enable generic SMC logic
      memory: atmel-ebi: Properly handle multiple reference to the same CS
      memory: atmel-ebi: Enable the SMC clock if specified

Chanwoo Choi (1):
      soc: samsung: pm_domains: Add new Exynos5433 compatible

Christophe Jaillet (1):
      memory: tegra: Add a missing 'of_node_put()' call

Elaine Zhang (4):
      soc: rockchip: power-domain: Support domain control in hiword-registers
      dt-bindings: power: add RK3328 SoCs header for idle-request
      dt-bindings: add binding for rk3328 power domains
      soc: rockchip: power-domain: add power domain support for rk3328

Heiko Stuebner (4):
      Merge branch 'v4.11-shared/pdids' into v4.11-armsoc/drivers
      dt-bindings: add used but undocumented rockchip grf compatible values
      soc: rockchip: add driver handling grf setup
      ARM: rockchip: drop rk3288 jtag/mmc switch handling

Heiner Kallweit (1):
      reset: core: fix reset_control_put

Jiancheng Xue (1):
      reset: ti_syscon: fix a ti_syscon_reset_status issue

Krzysztof Kozlowski (2):
      soc: samsung: pmu: Remove unused and duplicated defines
      soc: samsung: pmu: Remove duplicated define for ARM_L2_OPTION register

Linus Walleij (1):
      bus: qcom_ebi2: default y if ARCH_QCOM

Marek Szyprowski (9):
      soc: samsung: pmu: Provide global function to get PMU regmap
      soc: samsung: pmu: Use of_device_get_match_data helper
      soc: samsung: pmu: Remove messages for failed memory allocation
      soc: samsung: pmu: Add dummy support for Exynos5433 SoC
      soc: samsung: pm_domains: Use full names in subdomains registration log
      soc: samsung: pm_domains: Remove unused name field
      soc: samsung: pm_domains: Remove message about failed memory allocation
      soc: samsung: pm_domains: Read domain name from the new label property
      soc: samsung: pmu: Add register defines for pad retention control

Masahiro Yamada (1):
      reset: uniphier: add compatible string for LD11 SD-reset block

Murali Karicheri (2):
      soc: ti: knav_dma: fix typos in trace message
      soc: ti: knav: cleanup includes and sort header files

Olof Johansson (11):
      Merge tag 'at91-ab-4.11-drivers' of git://git.kernel.org/.../abelloni/linux into next/drivers
      Merge tag 'reset-for-4.11' of git://git.pengutronix.de/pza/linux into next/drivers
      Merge tag 'samsung-drivers-soc-pmu-4.11' of git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'v4.11-armsoc-drivers1' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'keystone_soc_for_4.11' of git://git.kernel.org/.../ssantosh/linux-keystone into next/drivers
      Merge tag 'qcom-drivers-for-4.11' of git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'omap-for-v4.11/drivers-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/drivers
      Merge tag 'tegra-for-4.11-memory' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'at91-ab-4.11-drivers2' of git://git.kernel.org/.../abelloni/linux into next/drivers
      Merge tag 'zte-pd-4.11' of git://git.kernel.org/.../shawnguo/linux into next/drivers
      Merge tag 'samsung-drivers-soc-pmu-4.11-2' of git://git.kernel.org/.../krzk/linux into next/drivers

Paul Gortmaker (1):
      reset: make zx2967 explicitly non-modular

Pramod Gurav (1):
      MAINTAINERS: Update the files to include the Qualcomm DMA folder

Ramiro Oliveira (2):
      reset: Change shared flag from int to bool
      reset: make optional functions really optional

Sarangdhar Joshi (1):
      soc: ti: wkup_m3_ipc: Drop wait from wkup_m3_rproc_boot_thread

Stanimir Varbanov (1):
      firmware: qcom: scm: Add empty functions to help compile testing

Suman Anna (1):
      Documentation: dt: reset: Revise typos in TI syscon reset example

Zhangfei Gao (2):
      dt-bindings: Document the hi3660 reset bindings
      reset: hisilicon: add reset-hi3660

 .../devicetree/bindings/power/pd-samsung.txt       |   5 +
 .../bindings/reset/hisilicon,hi3660-reset.txt      |  43 +++++
 .../devicetree/bindings/reset/ti-syscon-reset.txt  |   8 +-
 .../devicetree/bindings/reset/uniphier-reset.txt   |  47 +++---
 .../devicetree/bindings/reset/zte,zx2967-reset.txt |  20 +++
 .../devicetree/bindings/soc/rockchip/grf.txt       |   4 +
 .../bindings/soc/rockchip/power_domain.txt         |   3 +
 .../devicetree/bindings/soc/zte/pd-2967xx.txt      |  19 +++
 MAINTAINERS                                        |   7 +
 arch/arm/mach-exynos/suspend.c                     |   6 +-
 arch/arm/mach-rockchip/rockchip.c                  |  12 --
 drivers/ata/ahci.h                                 |   3 +
 drivers/ata/ahci_da850.c                           | 175 ++++++++++++++++++--
 drivers/ata/libahci.c                              |  18 +-
 drivers/bus/Kconfig                                |   1 +
 drivers/firmware/qcom_scm-32.c                     |  18 ++
 drivers/firmware/qcom_scm-64.c                     |  16 ++
 drivers/firmware/qcom_scm.c                        |   8 +-
 drivers/firmware/qcom_scm.h                        |   2 +
 drivers/memory/atmel-ebi.c                         | 126 ++++++++------
 drivers/memory/tegra/tegra124-emc.c                |   5 +-
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |  55 +++++--
 drivers/reset/hisilicon/Kconfig                    |   7 +
 drivers/reset/hisilicon/Makefile                   |   1 +
 drivers/reset/hisilicon/reset-hi3660.c             | 126 ++++++++++++++
 drivers/reset/reset-ti-syscon.c                    |   6 +-
 drivers/reset/reset-uniphier.c                     |   4 +
 drivers/reset/reset-zx2967.c                       |  99 +++++++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/rockchip/Kconfig                       |  10 ++
 drivers/soc/rockchip/Makefile                      |   1 +
 drivers/soc/rockchip/grf.c                         | 134 +++++++++++++++
 drivers/soc/rockchip/pm_domains.c                  |  63 ++++++-
 drivers/soc/samsung/exynos-pmu.c                   |  28 ++--
 drivers/soc/samsung/exynos5250-pmu.c               |   2 +-
 drivers/soc/samsung/exynos5420-pmu.c               |   4 +-
 drivers/soc/samsung/pm_domains.c                   |  31 ++--
 drivers/soc/ti/knav_dma.c                          |   4 +-
 drivers/soc/ti/knav_qmss_acc.c                     |  15 +-
 drivers/soc/ti/knav_qmss_queue.c                   |  25 +--
 drivers/soc/ti/wkup_m3_ipc.c                       |   2 -
 drivers/soc/zte/Kconfig                            |  13 ++
 drivers/soc/zte/Makefile                           |   5 +
 drivers/soc/zte/zx296718_pm_domains.c              | 182 +++++++++++++++++++++
 drivers/soc/zte/zx2967_pm_domains.c                | 143 ++++++++++++++++
 drivers/soc/zte/zx2967_pm_domains.h                |  44 +++++
 include/dt-bindings/power/rk3328-power.h           |  18 ++
 include/dt-bindings/soc/zte,pm_domains.h           |  24 +++
 include/linux/qcom_scm.h                           |  54 ++++--
 include/linux/reset.h                              |  45 ++---
 include/linux/soc/samsung/exynos-pmu.h             |  10 ++
 include/linux/soc/samsung/exynos-regs-pmu.h        |  91 +++--------
 55 files changed, 1505 insertions(+), 296 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 create mode 100644 Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt
 create mode 100644 drivers/reset/hisilicon/reset-hi3660.c
 create mode 100644 drivers/reset/reset-zx2967.c
 create mode 100644 drivers/soc/rockchip/grf.c
 create mode 100644 drivers/soc/zte/Kconfig
 create mode 100644 drivers/soc/zte/Makefile
 create mode 100644 drivers/soc/zte/zx296718_pm_domains.c
 create mode 100644 drivers/soc/zte/zx2967_pm_domains.c
 create mode 100644 drivers/soc/zte/zx2967_pm_domains.h
 create mode 100644 include/dt-bindings/power/rk3328-power.h
 create mode 100644 include/dt-bindings/soc/zte,pm_domains.h
