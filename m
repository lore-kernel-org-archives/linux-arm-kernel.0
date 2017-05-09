From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 May 2017 23:52:51 -0700
Subject: [GIT PULL 5/7] ARM: SoC driver updates
In-Reply-To: <1494312773-9790-1-git-send-email-olof@lixom.net>
References: <1494312773-9790-1-git-send-email-olof@lixom.net>
Message-ID: <1494312773-9790-6-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver updates for ARM SoCs.

* Reset subsystem, merged through arm-soc by tradition:
- Make bool drivers explicitly non-modular
- New support for i.MX7 and Arria10 reset controllers

* PATA driver for Palmchip BK371 (acked by Tejun)

* Power domain drivers for i.MX (GPC, GPCv2)
- Moved out of mach-imx for GPC
- Bunch of tweaks, fixes, etc

* PMC support for Tegra186

* SoC detection support for Renesas RZ/G1H and RZ/G1N

* Move Tegra flow controller driver from mach directory to drivers/soc
- (Power management / CPU power driver)

* Misc smaller tweaks for other platforms

----------------------------------------------------------------

The following changes since commit 51cc83299ee9314351569df5267b891130cef79b:

  Merge tag 'armsoc-defconfig' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to b6942b68f85ed3161c91741791ec6f1779574919:

  Merge branch 'for_4.12/soc-pmdomain-p2' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone into next/drivers

----------------------------------------------------------------

Alexey Klimov (1):
      firmware: arm_scpi: reinit completion instead of full init_completion()

Andre Przywara (1):
      reset: sunxi: fix for 64-bit compilation

Andrey Smirnov (3):
      reset: Add i.MX7 SRC reset driver
      dt-bindings: Add GPCv2 power gating driver
      soc: imx: Add GPCv2 power gating driver

Arnd Bergmann (4):
      Merge tag 'amlogic-drivers' of git://git.kernel.org/.../khilman/linux-amlogic into next/drivers
      Merge tag 'arm-soc/for-4.12/drivers' of http://github.com/Broadcom/stblinux into next/drivers
      soc/tegra: Fix link errors with PMC disabled
      Merge branch 'for_4.12/soc-pmdomain-p2' of git://git.kernel.org/.../ssantosh/linux-keystone into next/drivers

Bartlomiej Zolnierkiewicz (3):
      ata: add Palmchip BK3710 PATA controller driver
      pata_bk3710: disable IORDY Timer on chipset initialization
      pata_bk3710: clear status bits of BMISP on chipset initialization

Carlo Caione (2):
      firmware: meson-sm: Check for buffer output size
      firmware: meson-sm: Allow 0 as valid return value

Dave Gerlach (5):
      PM / Domains: Add generic data pointer to genpd data struct
      PM / Domains: Do not check if simple providers have phandle cells
      dt-bindings: Add TI SCI PM Domains
      soc: ti: Add ti_sci_pm_domains driver
      ARM: keystone: Drop PM domain support for k2g

Dong Aisheng (8):
      soc: imx: gpc: fix gpc clk get error handling
      soc: imx: gpc: fix the wrong using of regmap cache
      soc: imx: gpc: fix domain_index sanity check issue
      soc: imx: gpc: fix imx6sl gpc power domain regression
      soc: imx: gpc: fix comment when power up domain
      soc: imx: gpc: keep PGC_X_CTRL name align with reference manual
      dt-bindings: imx-gpc: correct the DOMAIN_INDEX using
      soc: imx: gpc: remove unnecessary readable_reg callback

Florian Fainelli (1):
      soc: bcm: brcmstb: Match additional compatible strings

Geert Uytterhoeven (7):
      soc: renesas: Identify RZ/G1H
      soc: renesas: Identify RZ/G1N
      base: soc: Let soc_device_match() return no match when called too early
      base: soc: Allow early registration of a single SoC device
      soc: renesas: Register SoC device early
      soc: renesas: rcar-sysc: Add support for fixing up power area tables
      soc: renesas: rcar-sysc: Add support for R-Car H3 ES2.0

Jon Hunter (4):
      ARM: tegra: Remove unnecessary inclusion of flowctrl header
      soc/tegra: Move Tegra flowctrl driver
      soc/tegra: flowctrl: Add basic platform driver
      soc/tegra: Add initial flowctrl support for Tegra132/210

Krzysztof Kozlowski (1):
      soc: samsung: Do not build ARMv7 PMU drivers on ARMv8

Linus Walleij (2):
      ARM: plat-versatile: remove stale clock header
      ARM/clk: move the ICST library to drivers/clk

Lucas Stach (5):
      dt-bindings: add multidomain support to i.MX GPC DT binding
      soc: imx: move PGC handling to a new GPC driver
      soc: imx: gpc: add defines for domain index
      dt-bindings: imx-gpc: add i.MX6 QuadPlus compatible
      soc: imx: gpc: add workaround for i.MX6QP to the GPC PD driver

Masahiro Yamada (1):
      reset: uniphier: add NAND and eMMC reset control

Olof Johansson (13):
      Merge tag 'reset-for-4.12-1' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'renesas-drivers-for-v4.12' of https://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'scpi-update-4.12' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'davinci-for-v4.12/drivers' of git://git.kernel.org/.../nsekhar/linux-davinci into next/drivers
      Merge tag 'reset-for-4.12-2' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'arm-soc-pmdomain' of git://git.kernel.org/.../ssantosh/linux-keystone into next/drivers
      Merge tag 'tegra-for-4.12-soc' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'qcom-drivers-for-4.12' of git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'arm-to-clk-icst' of git://git.kernel.org/.../linusw/linux-integrator into next/drivers
      Merge tag 'imx-drivers-4.12' of git://git.kernel.org/.../shawnguo/linux into next/drivers
      Merge tag 'zte-drivers-4.12' of git://git.kernel.org/.../shawnguo/linux into next/drivers
      Merge tag 'renesas-sysc-for-v4.12' of https://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'samsung-drivers-4.12' of git://git.kernel.org/.../krzk/linux into next/drivers

Paul Gortmaker (5):
      reset: meson: make it explicitly non-modular
      reset: oxnas: make it explicitly non-modular
      reset: ath79: make it explicitly non-modular
      reset: pistachio: make it explicitly non-modular
      soc: tegra: make fuse-tegra explicitly non-modular

Rob Clark (1):
      firmware/qcom: add qcom_scm_restore_sec_cfg()

Rojhalat Ibrahim (1):
      reset-socfpga: Fix nr_resets property

Santosh Shilimkar (1):
      soc: pm-domain: Fix the mangled urls

Stanimir Varbanov (1):
      firmware: qcom_scm: add two scm calls for iommu secure page table

Thierry Reding (1):
      soc/tegra: Implement Tegra186 PMC support

Thor Thayer (2):
      dt-bindings: reset: a10sr: Add Arria10 SR Reset Controller offsets
      reset: Add Altera Arria10 SR Reset Controller

Wei Yongjun (3):
      reset: uniphier: fix non static symbol warnings
      soc: zte: pm_domains: Remove redundant dev_err call in zx2967_pd_probe()
      soc: zte: pm_domains: Remove .owner field for driver


 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt  |  34 ++
 .../devicetree/bindings/power/fsl,imx-gpc.txt   |  85 ++--
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt |  71 +++
 .../devicetree/bindings/reset/fsl,imx7-src.txt  |  47 ++
 .../bindings/soc/ti/sci-pm-domain.txt           |  57 +++
 MAINTAINERS                                     |   6 +
 arch/arm/common/Kconfig                         |   3 -
 arch/arm/common/Makefile                        |   1 -
 arch/arm/mach-imx/gpc.c                         | 217 --------
 arch/arm/mach-keystone/Kconfig                  |   1 +
 arch/arm/mach-keystone/pm_domain.c              |   4 +-
 arch/arm/mach-tegra/Makefile                    |   1 -
 arch/arm/mach-tegra/cpuidle-tegra20.c           |   3 +-
 arch/arm/mach-tegra/platsmp.c                   |   2 +-
 arch/arm/mach-tegra/pm.c                        |   2 +-
 arch/arm/mach-tegra/reset-handler.S             |   2 +-
 arch/arm/mach-tegra/sleep-tegra20.S             |   3 +-
 arch/arm/mach-tegra/sleep-tegra30.S             |   2 +-
 arch/arm/mach-tegra/sleep.S                     |   2 -
 arch/arm/mach-tegra/tegra.c                     |   2 -
 arch/arm/plat-versatile/include/plat/clock.h    |  15 -
 drivers/ata/Kconfig                             |   9 +
 drivers/ata/Makefile                            |   1 +
 drivers/ata/pata_bk3710.c                       | 382 +++++++++++++++
 drivers/base/power/domain.c                     |   2 -
 drivers/base/soc.c                              |  52 +-
 drivers/clk/versatile/Kconfig                   |   3 +
 drivers/clk/versatile/Makefile                  |   2 +-
 drivers/clk/versatile/clk-icst.c                |   1 +
 drivers/clk/versatile/clk-icst.h                |   2 -
 drivers/clk/versatile/clk-impd1.c               |   1 +
 drivers/clk/versatile/clk-realview.c            |   1 +
 drivers/clk/versatile/clk-versatile.c           |   1 +
 .../arm/common => drivers/clk/versatile}/icst.c |   2 +-
 .../hardware => drivers/clk/versatile}/icst.h   |   6 +-
 drivers/firmware/arm_scpi.c                     |   7 +-
 drivers/firmware/meson/meson_sm.c               |  20 +-
 drivers/firmware/qcom_scm-32.c                  |  18 +
 drivers/firmware/qcom_scm-64.c                  |  58 +++
 drivers/firmware/qcom_scm.c                     |  18 +
 drivers/firmware/qcom_scm.h                     |  11 +
 drivers/nvmem/meson-efuse.c                     |   2 +-
 drivers/reset/Kconfig                           |  14 +
 drivers/reset/Makefile                          |   3 +
 drivers/reset/reset-a10sr.c                     | 138 ++++++
 drivers/reset/reset-ath79.c                     |  27 +-
 drivers/reset/reset-imx7.c                      | 158 ++++++
 drivers/reset/reset-meson.c                     |  12 +-
 drivers/reset/reset-oxnas.c                     |   6 +-
 drivers/reset/reset-pistachio.c                 |   9 +-
 drivers/reset/reset-socfpga.c                   |  13 +-
 drivers/reset/reset-sunxi.c                     |  18 +-
 drivers/reset/reset-uniphier.c                  |  37 +-
 drivers/soc/Kconfig                             |   1 +
 drivers/soc/Makefile                            |   1 +
 drivers/soc/bcm/brcmstb/common.c                |   9 +
 drivers/soc/imx/Kconfig                         |   9 +
 drivers/soc/imx/Makefile                        |   2 +
 drivers/soc/imx/gpc.c                           | 489 +++++++++++++++++++
 drivers/soc/imx/gpcv2.c                         | 363 ++++++++++++++
 drivers/soc/renesas/r8a7795-sysc.c              |  26 +-
 drivers/soc/renesas/rcar-sysc.c                 |  25 +-
 drivers/soc/renesas/rcar-sysc.h                 |  10 +
 drivers/soc/renesas/renesas-soc.c               |  18 +-
 drivers/soc/samsung/Kconfig                     |   8 +-
 drivers/soc/samsung/Makefile                    |   4 +-
 drivers/soc/samsung/exynos-pmu.c                |  22 +-
 drivers/soc/samsung/exynos-pmu.h                |   3 +
 drivers/soc/tegra/Kconfig                       |  22 +
 drivers/soc/tegra/Makefile                      |   4 +-
 .../mach-tegra => drivers/soc/tegra}/flowctrl.c |  87 +++-
 drivers/soc/tegra/fuse/fuse-tegra.c             |   4 +-
 drivers/soc/tegra/pmc-tegra186.c                | 169 +++++++
 drivers/soc/ti/Kconfig                          |  12 +
 drivers/soc/ti/Makefile                         |   1 +
 drivers/soc/ti/ti_sci_pm_domains.c              | 202 ++++++++
 drivers/soc/zte/zx296718_pm_domains.c           |   1 -
 drivers/soc/zte/zx2967_pm_domains.c             |   4 +-
 include/dt-bindings/genpd/k2g.h                 |  90 ++++
 include/dt-bindings/power/imx7-power.h          |  16 +
 include/dt-bindings/power/r8a7795-sysc.h        |   2 +-
 include/dt-bindings/reset/altr,rst-mgr-a10sr.h  |  33 ++
 include/dt-bindings/reset/imx7-reset.h          |  62 +++
 include/linux/firmware/meson/meson_sm.h         |   4 +-
 include/linux/pm_domain.h                       |   1 +
 include/linux/qcom_scm.h                        |   6 +
 .../mach-tegra => include/soc/tegra}/flowctrl.h |  32 +-
 include/soc/tegra/pmc.h                         |  29 +-
 88 files changed, 2937 insertions(+), 428 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 delete mode 100644 arch/arm/plat-versatile/include/plat/clock.h
 create mode 100644 drivers/ata/pata_bk3710.c
 rename {arch/arm/common => drivers/clk/versatile}/icst.c (98%)
 rename {arch/arm/include/asm/hardware => drivers/clk/versatile}/icst.h (94%)
 create mode 100644 drivers/reset/reset-a10sr.c
 create mode 100644 drivers/reset/reset-imx7.c
 create mode 100644 drivers/soc/imx/Kconfig
 create mode 100644 drivers/soc/imx/Makefile
 create mode 100644 drivers/soc/imx/gpc.c
 create mode 100644 drivers/soc/imx/gpcv2.c
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/flowctrl.c (67%)
 create mode 100644 drivers/soc/tegra/pmc-tegra186.c
 create mode 100644 drivers/soc/ti/ti_sci_pm_domains.c
 create mode 100644 include/dt-bindings/genpd/k2g.h
 create mode 100644 include/dt-bindings/power/imx7-power.h
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-a10sr.h
 create mode 100644 include/dt-bindings/reset/imx7-reset.h
 rename {arch/arm/mach-tegra => include/soc/tegra}/flowctrl.h (77%)
