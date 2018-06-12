From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Jun 2018 17:01:41 -0700
Subject: [GIT PULL 3/4] ARM: SoC driver updates
In-Reply-To: <20180612000142.28883-1-olof@lixom.net>
References: <20180612000142.28883-1-olof@lixom.net>
Message-ID: <20180612000142.28883-4-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains platform-related driver updates for ARM and ARM64.

Highlights:
- ARM SCMI (System Control & Management Interface) driver cleanups
- Hisilicon support for LPC bus w/ ACPI
- Reset driver updates for several platforms: Uniphier,
- Rockchip power domain bindings and hardware descriptions for several SoCs.
- Tegra memory controller reset improvements


Conflicts: None

----------------------------------------------------------------

The following changes since commit f6842ec05a77253b953ab67152915fe7df887d40:

  Merge branch 'next/dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to 32561354b16944e784e82a2011765c50e77e1c56:

  ARM: tegra: fix compile-testing PCI host driver

----------------------------------------------------------------

Andrey Smirnov (2):
      soc: imx: gpcv2: Do not pass static memory as platform data
      soc: imx: gpc: Do not pass static memory as platform data

Arnd Bergmann (1):
      ARM: tegra: fix compile-testing PCI host driver

Bartosz Golaszewski (2):
      memory: aemif: don't rely on kbuild for driver's name
      memory: aemif: add support for board files

Caesar Wang (3):
      dt-bindings: power: add RK3036 SoCs header for power-domain
      dt-bindings: power: add binding for rk3036 power domains
      soc: rockchip: power-domain: add power domain support for rk3036

Dmitry Osipenko (14):
      dt-bindings: memory: tegra: Add hot resets definitions
      memory: tegra: Do not handle spurious interrupts
      memory: tegra: Setup interrupts mask before requesting IRQ
      memory: tegra: Apply interrupts mask per SoC
      memory: tegra: Remove unused headers inclusions
      memory: tegra: Squash tegra20-mc into common tegra-mc driver
      memory: tegra: Introduce memory client hot reset
      memory: tegra: Add Tegra20 memory controller hot resets
      memory: tegra: Add Tegra30 memory controller hot resets
      memory: tegra: Add Tegra114 memory controller hot resets
      memory: tegra: Add Tegra124 memory controller hot resets
      memory: tegra: Register SMMU after MC driver became ready
      memory: tegra: Remove Tegra114 SATA and AFI reset definitions
      dt-bindings: memory: tegra: Remove Tegra114 SATA and AFI reset definitions

Elaine Zhang (6):
      dt-bindings: power: add RK3128 SoCs header for power-domain
      dt-bindings: power: add binding for rk3128 power domains
      soc: rockchip: power-domain: add power domain support for rk3128
      dt-bindings: power: add RK3228 SoCs header for power-domain
      dt-bindings: power: add binding for rk3228 power domains
      soc: rockchip: power-domain: add power domain support for rk3228

Finley Xiao (4):
      soc: rockchip: power-domain: Fix wrong value when power up pd with writemask
      dt-bindings: power: add PX30 SoCs header for power-domain
      dt-bindings: power: add binding for px30 power domains
      soc: rockchip: power-domain: add power domain support for px30

Florian Fainelli (1):
      memory: brcmstb: dpfe: Remove need for dpfe_dev

John Garry (3):
      HISI LPC: Stop using MFD APIs
      HISI LPC: Re-Add ACPI child enumeration support
      HISI LPC: Add ACPI UART support

Katsuhiro Suzuki (1):
      reset: uniphier: add LD11/LD20 stream demux system reset control

Kunihiko Hayashi (2):
      reset: uniphier: add PCIe reset control support
      reset: uniphier: add SATA reset control support and change SATA-PHY ID

Lokesh Vutla (1):
      firmware: ti_sci: Switch to SPDX Licensing

Marek Szyprowski (1):
      soc: samsung: pm_domains: Deprecate support for clocks

Matthias Brugger (1):
      Merge commit 'f15cd6d99198e9c15229aefec639a34a6e8174c6' into v.4.17-next/soc-test

Olof Johansson (12):
      Merge tag 'soc_drivers_for_4.18' of git://git.kernel.org/.../ssantosh/linux-keystone into next/drivers
      Merge tag 'gpmc-omap-for-v4.18' of https://github.com/rogerq/linux into next/drivers
      Merge tag 'hisi-drivers-for-4.18' of git://github.com/hisilicon/linux-hisi into next/drivers
      Merge tag 'arm-soc/for-4.18/drivers' of https://github.com/Broadcom/stblinux into next/drivers
      Merge tag 'samsung-drivers-4.18' of https://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'v4.17-next-soc' of https://git.kernel.org/.../matthias.bgg/linux into next/drivers
      Merge tag 'scmi-updates-4.18' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'reset-for-4.18' of git://git.pengutronix.de/pza/linux into next/drivers
      Merge tag 'v4.18-rockchip-drivers-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'tegra-for-4.18-memory-v2' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'imx-drivers-4.18' of git://git.kernel.org/.../shawnguo/linux into next/drivers
      Merge tag 'v4.18-rockchip-drivers-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers

Roger Quadros (1):
      memory: omap-gpmc: Avoid redundant NULL check

Ryder Lee (1):
      soc: mediatek: use of_device_get_match_data()

Sean Wang (5):
      soc: mediatek: reuse read[l,x]_poll_timeout helpers
      soc: mediatek: reuse regmap_read_poll_timeout helpers
      soc: mediatek: introduce a CAPS flag for scp_domain_data
      soc: mediatek: add a fixed wait for SRAM stable
      soc: mediatek: remove unneeded semicolon

Stefan Agner (1):
      bus: arm-cci: remove unnecessary unreachable()

Sudeep Holla (8):
      firmware: arm_scmi: improve code readability using bitfield accessor macros
      firmware: arm_scmi: fix kernel-docs documentation
      firmware: arm_scmi: rename get_transition_latency and add_opps_to_device
      firmware: arm_scmi: rename scmi_xfer_{init,get,put}
      firmware: arm_scmi: drop unused `con_priv` structure member
      firmware: arm_scmi: remove unnecessary bitmap_zero
      firmware: arm_scmi: improve exit paths and code readability
      firmware: arm_scmi: simplify exit path by returning on error

Thierry Reding (1):
      memory: tegra: Add Tegra210 memory controller hot resets

Vasyl Gomonovych (1):
      soc: ti: knav_qmss: Use percpu instead atomic for stats counter


 .../devicetree/bindings/power/pd-samsung.txt    |  20 +-
 .../bindings/soc/rockchip/power_domain.txt      |  12 +
 drivers/bus/Kconfig                             |   1 -
 drivers/bus/arm-cci.c                           |   2 -
 drivers/bus/hisi_lpc.c                          | 159 ++++----
 drivers/cpufreq/scmi-cpufreq.c                  |   4 +-
 drivers/firmware/arm_scmi/base.c                |  43 ++-
 drivers/firmware/arm_scmi/bus.c                 |  22 +-
 drivers/firmware/arm_scmi/clock.c               |  24 +-
 drivers/firmware/arm_scmi/common.h              |  22 +-
 drivers/firmware/arm_scmi/driver.c              | 109 +++---
 drivers/firmware/arm_scmi/perf.c                |  38 +-
 drivers/firmware/arm_scmi/power.c               |  16 +-
 drivers/firmware/arm_scmi/sensors.c             |  20 +-
 drivers/firmware/ti_sci.c                       |  10 +-
 drivers/firmware/ti_sci.h                       |  30 +-
 drivers/memory/Kconfig                          |  10 -
 drivers/memory/Makefile                         |   1 -
 drivers/memory/brcmstb_dpfe.c                   |  42 +--
 drivers/memory/omap-gpmc.c                      |   4 +-
 drivers/memory/tegra/Makefile                   |   1 +
 drivers/memory/tegra/mc.c                       | 362 +++++++++++++++++--
 drivers/memory/tegra/mc.h                       |  22 ++
 drivers/memory/tegra/tegra114.c                 |  33 ++
 drivers/memory/tegra/tegra124.c                 |  48 +++
 drivers/memory/tegra/tegra20.c                  | 296 +++++++++++++++
 drivers/memory/tegra/tegra210.c                 |  53 ++-
 drivers/memory/tegra/tegra30.c                  |  35 ++
 drivers/memory/tegra20-mc.c                     | 254 -------------
 drivers/memory/ti-aemif.c                       |  60 +--
 drivers/reset/reset-uniphier.c                  |  13 +-
 drivers/soc/imx/gpc.c                           |  18 +-
 drivers/soc/imx/gpcv2.c                         |  22 +-
 drivers/soc/mediatek/mtk-infracfg.c             |  46 +--
 drivers/soc/mediatek/mtk-pmic-wrap.c            |  13 +-
 drivers/soc/mediatek/mtk-scpsys.c               | 167 ++++-----
 drivers/soc/rockchip/pm_domains.c               | 117 +++++-
 drivers/soc/samsung/pm_domains.c                |  90 +----
 drivers/soc/ti/knav_qmss.h                      |  14 +-
 drivers/soc/ti/knav_qmss_queue.c                |  60 ++-
 include/dt-bindings/memory/tegra114-mc.h        |  17 +
 include/dt-bindings/memory/tegra124-mc.h        |  25 ++
 include/dt-bindings/memory/tegra20-mc.h         |  21 ++
 include/dt-bindings/memory/tegra210-mc.h        |  31 ++
 include/dt-bindings/memory/tegra30-mc.h         |  19 +
 include/dt-bindings/power/px30-power.h          |  27 ++
 include/dt-bindings/power/rk3036-power.h        |  13 +
 include/dt-bindings/power/rk3128-power.h        |  14 +
 include/dt-bindings/power/rk3228-power.h        |  21 ++
 include/linux/platform_data/ti-aemif.h          |  25 ++
 include/linux/scmi_protocol.h                   |  18 +-
 include/linux/soc/ti/ti_sci_protocol.h          |  10 +-
 include/soc/tegra/cpuidle.h                     |   2 +-
 include/soc/tegra/mc.h                          |  37 +-
 54 files changed, 1677 insertions(+), 916 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra20.c
 delete mode 100644 drivers/memory/tegra20-mc.c
 create mode 100644 include/dt-bindings/memory/tegra20-mc.h
 create mode 100644 include/dt-bindings/power/px30-power.h
 create mode 100644 include/dt-bindings/power/rk3036-power.h
 create mode 100644 include/dt-bindings/power/rk3128-power.h
 create mode 100644 include/dt-bindings/power/rk3228-power.h
