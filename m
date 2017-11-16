From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Nov 2017 23:02:39 +0100
Subject: [GIT PULL 2/3] ARM: SoC driver updates for 4.15
Message-ID: <CAK8P3a2Wp6EANLq7JZr=uAReKOhBYrc3VKUA7FpDvq7n3Lc2aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-drivers

for you to fetch changes up to 339cd0ea082287ea8e2b7e7159a5a33665a2cbe3:

  soc: amlogic: meson-gx-pwrc-vpu: fix power-off when powered by
bootloader (2017-11-09 11:42:17 +0100)

----------------------------------------------------------------
ARM: SoC driver updates for v4.15

This branch contains platform-related driver updates for ARM and ARM64,
these are the areas that bring the changes:

New drivers:
 - Driver support for Renesas R-Car V3M (R8A77970)
 - Power management support for Amlogic GX
 - A new driver for the Tegra BPMP thermal sensor
 - A new bus driver for Technologic Systems NBUS

Changes for subsystems that prefer to merge through arm-soc:
 - The usual updates for reset controller drivers from Philipp Zabel,
   with five added drivers for SoCs in the arc, meson, socfpa, uniphier
   and mediatek families.
 - Updates to the ARM SCPI and PSCI frameworks, from Sudeep Holla,
   Heiner Kallweit and Lorenzo Pieralisi.

Changes specific to some ARM-based SoC
 - The Freescale/NXP DPAA QBMan drivers from PowerPC can now work
   on ARM as well.
 - Several changes for power management on Broadcom SoCs
 - Various improvements on Qualcomm, Broadcom, Amlogic, Atmel, Mediatek
 - Minor Cleanups for Samsung, TI OMAP SoCs

----------------------------------------------------------------
Alexandre Belloni (1):
      MAINTAINERS: Add SoC drivers to AT91 entry

Arnd Bergmann (21):
      Merge tag 'arm-soc/for-4.15/drivers' of
http://github.com/Broadcom/stblinux into next/drivers
      Merge tag 'renesas-drivers-for-v4.15' of
https://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'scpi-updates-4.15' of
git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'samsung-drivers-4.15' of
git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'qcom-drivers-for-4.15' of
git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'gpmc-omap-for-v4.15' of
https://github.com/rogerq/linux into next/drivers
      Merge tag 'reset-for-4.15' of
git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'soc-fsl-for-4.14' of
git://git.kernel.org/.../leo/linux into next/drivers
      Merge tag 'tegra-for-4.15-firmware' of
ssh://gitolite.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.15-soc' of
ssh://gitolite.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.15-thermal' of
ssh://gitolite.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'arm-soc/for-4.15/drivers-part2' of
http://github.com/Broadcom/stblinux into next/drivers
      Merge tag 'keystone_soc_drivers_4.15' of
ssh://gitolite.kernel.org/.../ssantosh/linux-keystone into
next/drivers
      Merge tag 'qcom-drivers-for-4.15-2' of
ssh://gitolite.kernel.org/.../agross/linux into next/drivers
      Merge tag 'amlogic-drivers' of
ssh://gitolite.kernel.org/.../khilman/linux-amlogic into next/drivers
      Merge tag 'at91-ab-4.15-soc' of
ssh://gitolite.kernel.org/.../abelloni/linux into next/drivers
      Merge tag 'v4.14-next-soc' of
https://github.com/mbgg/linux-mediatek into next/drivers
      Merge tag 'amlogic-drivers-2' of
ssh://gitolite.kernel.org/.../khilman/linux-amlogic into next/drivers
      soc: amlogic: gx pm domain: add PM and OF dependencies
      soc: qcom: remove unused label
      Merge tag 'gpmc-omap-for-v4.15-pt2' of
https://github.com/rogerq/linux into next/drivers

Bjorn Andersson (8):
      soc: qcom: smem: Rename "uncached" accessors
      soc: qcom: smem: Support getting cached entries
      firmware: qcom: scm: Expose secure IO service
      firmware: qcom: scm: Expose download-mode control
      of/platform: Generalize /reserved-memory handling
      of: reserved_mem: Accessor for acquiring reserved_mem
      dt-binding: soc: qcom: Add binding for rmtfs memory
      soc: qcom: Remote filesystem memory driver

Brian Norris (1):
      soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)

Chenglin Xu (1):
      soc: mediatek: pwrap: add support for MT7622 SoC

Chris Lew (5):
      soc: qcom: smem: Use le32_to_cpu for comparison
      soc: qcom: smem: Read version from the smem header
      soc: qcom: smem: Support global partition
      soc: qcom: smem: Support dynamic item limit
      soc: qcom: smem: Increase the number of hosts

Claudiu Manoil (2):
      soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
      soc/fsl/qbman: Add missing headers on ARM

Cristian Birsan (1):
      drivers: soc: atmel: Add basic support for new sama5d2 SiPs

Dinh Nguyen (1):
      reset: socfpga: build the reset-socfpga for Stratix10 SOC

Eugeniy Paltsev (1):
      ARC: reset: introduce AXS10x reset driver

Florian Fainelli (3):
      dt-bindings: ARM: brcmstb: Update Broadcom STB Power Management binding
      dt-bindings: Document MIPS Broadcom STB power management nodes
      clk: bcm: Add Broadcom Hurricane 2 clock support

Heiner Kallweit (9):
      firmware: arm_scpi: remove usage of drvdata and don't reset
scpi_info to null
      firmware: arm_scpi: remove two unneeded devm_kfree's in scpi_remove
      firmware: arm_scpi: pre-populate dvfs info in scpi_probe
      firmware: arm_scpi: make freeing mbox channels device-managed
      firmware: arm_scpi: remove scpi_remove
      firmware: arm_scpi: improve struct dvfs_info to make code better readable
      firmware: arm_scpi: improve handling of protocol and firmware
version subfields
      firmware: arm_scpi: improve struct sensor_value
      firmware: arm_scpi: silence sparse warnings

Helge Deller (1):
      ti_sci: Use %pS printk format for direct addresses

Jean Delvare (1):
      soc: Allow test-building of MediaTek drivers

Justin Chen (1):
      soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS)

Karim Eshapa (1):
      soc/fsl/qman: Sleep instead of stuck hacking jiffies

Kunihiko Hayashi (1):
      reset: uniphier: add ethernet reset control support

Ladislav Michl (2):
      memory: omap-gpmc: Drop gpmc_status
      memory: omap-gpmc: Remove deprecated gpmc_update_nand_reg()

Lorenzo Pieralisi (1):
      drivers/firmware: psci_checker: Add missing destroy_timer_on_stack()

Madalin Bucur (4):
      soc/fsl/qbman: Drop set/clear_bits usage
      soc/fsl/qbman: add QMAN_REV32
      soc/fsl/qbman: different register offsets on ARM
      soc/fsl/qbman: Enable FSL_LAYERSCAPE config on ARM

Marek Szyprowski (1):
      soc: samsung: Remove Exynos4212 related dead code

Markus Mayer (4):
      dt-bindings: Add bindings for Broadcom STB DRAM Sensors
      memory: brcmstb: Add driver for DPFE
      memory: brcmstb: dpfe: introduce is_dcpu_enabled()
      memory: brcmstb: dpfe: skip downloading firmware when possible

Martin Blumenstingl (1):
      soc: amlogic: Add Meson6/Meson8/Meson8b/Meson8m2 SoC Information driver

Masahiro Yamada (1):
      reset: uniphier: add PXs3 reset data

Matthias Brugger (2):
      soc: mediatek: pwrap: fix compiler errors
      soc: mediatek: pwrap: fix fatal compiler error

Mikko Perttunen (4):
      dt-bindings: Add bindings for nvidia,tegra186-bpmp-thermal
      firmware: tegra: Expose tegra_bpmp_mrq_return()
      firmware: tegra: Add stubs when BPMP not enabled
      thermal: Add Tegra BPMP thermal sensor driver

Neil Armstrong (5):
      reset: meson: add level reset support for GX SoC family
      reset: meson: remove unneeded check in meson_reset_reset
      soc: amlogic: add Meson GX VPU Domains driver
      dt-bindings: power: add amlogic meson power domain bindings
      soc: amlogic: meson-gx-pwrc-vpu: fix power-off when powered by bootloader

Philipp Zabel (6):
      reset: add reset-simple to unify socfpga, stm32, sunxi, and zx2967
      reset: sunxi: use reset-simple driver
      reset: socfpga: use the reset-simple driver
      reset: stm32: use the reset-simple driver
      reset: zx2967: use the reset-simple driver
      Merge branch 'reset/arc' into reset/next

Roy Pledge (5):
      soc/fsl/qbman: Add common routine for QBMan private allocations
      soc/fsl/qbman: Use shared-dma-pool for BMan private memory allocations
      soc/fsl/qbman: Use shared-dma-pool for QMan private memory allocations
      dt-bindings: soc/fsl: Update reserved memory binding for QBMan
      soc/fsl/qbman: Rework portal mapping calls for ARM/PPC

Sean Wang (10):
      reset: mediatek: add reset controller dt-bindings required
header for MT7622 SoC
      soc: mediatek: pwrap: fixup warnings from coding style
      dt-bindings: arm: mediatek: add MT7622 string to the PMIC wrapper doc
      soc: mediatek: pwrap: add pwrap_read32 for reading in 32-bit mode
      soc: mediatek: pwrap: add pwrap_write32 for writing in 32-bit mode
      soc: mediatek: pwrap: refactor pwrap_init for the various PMIC types
      soc: mediatek: pwrap: add MediaTek MT6380 as one slave of pwrap
      soc: mediatek: pwrap: add common way for setup CS timing extenstion
      soc: mediatek: place Kconfig for all SoC drivers under menu
      arm64: mediatek: cleanup message for platform selection

Sebastien Bourdelin (1):
      bus: add driver for the Technologic Systems NBUS

Sergei Shtylyov (3):
      soc: renesas: rcar-rst: add R8A77970 support
      soc: renesas: identify R-Car V3M
      soc: renesas: rcar-sysc: add R8A77970 support

Sudeep Holla (2):
      firmware: arm_scpi: drop unnecessary type cast to scpi_shared_mem
      firmware: arm_scpi: remove all single element structures

Thierry Reding (4):
      dt-bindings: clock: tegra: Add sor1_out clock
      Merge branch 'for-4.15/dt-bindings' into for-4.15/thermal
      Merge branch 'for-4.15/firmware' into for-4.15/thermal
      Merge branch 'for-4.15/firmware' into for-4.15/soc

Thomas Meyer (1):
      ARM: mediatek: Cocci spatch "of_table"

Timo Alho (3):
      firmware: tegra: Propagate error code to caller
      firmware: tegra: Add BPMP debugfs support
      soc/tegra: bpmp: Check BPMP response return code

Valentin Rothberg (1):
      soc/fsl/qbman: Fix ARM32 typo

ashish kumar (1):
      soc/fsl/guts: Add compatible string for LS1088

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |   6 +-
 .../devicetree/bindings/arm/samsung/pmu.txt        |   1 -
 .../devicetree/bindings/firmware/qcom,scm.txt      |   2 +
 .../bindings/memory-controllers/brcm,dpfe-cpu.txt  |  27 +
 .../devicetree/bindings/mips/brcm/soc.txt          | 153 ++++
 .../bindings/power/amlogic,meson-gx-pwrc.txt       |  61 ++
 .../bindings/power/renesas,rcar-sysc.txt           |   1 +
 .../bindings/reserved-memory/qcom,rmtfs-mem.txt    |  51 ++
 .../devicetree/bindings/reset/renesas,rst.txt      |   1 +
 .../bindings/reset/snps,axs10x-reset.txt           |  33 +
 .../devicetree/bindings/reset/uniphier-reset.txt   |   3 +
 Documentation/devicetree/bindings/soc/fsl/bman.txt |  12 +-
 Documentation/devicetree/bindings/soc/fsl/qman.txt |  26 +-
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |   6 +-
 .../thermal/nvidia,tegra186-bpmp-thermal.txt       |  32 +
 MAINTAINERS                                        |  20 +-
 arch/arm/mach-mediatek/platsmp.c                   |   2 +
 arch/arm64/Kconfig.platforms                       |   5 +-
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/ts-nbus.c                              | 375 ++++++++++
 drivers/clk/bcm/Kconfig                            |   9 +
 drivers/clk/bcm/Makefile                           |   1 +
 drivers/clk/bcm/clk-hr2.c                          |  27 +
 drivers/firmware/Kconfig                           |  11 +
 drivers/firmware/arm_scpi.c                        | 216 +++---
 drivers/firmware/psci_checker.c                    |   1 +
 drivers/firmware/qcom_scm-32.c                     |  24 +
 drivers/firmware/qcom_scm-64.c                     |  44 ++
 drivers/firmware/qcom_scm.c                        |  87 +++
 drivers/firmware/qcom_scm.h                        |   8 +
 drivers/firmware/tegra/Makefile                    |   4 +-
 drivers/firmware/tegra/bpmp-debugfs.c              | 444 +++++++++++
 drivers/firmware/tegra/bpmp.c                      |  31 +-
 drivers/firmware/ti_sci.c                          |   2 +-
 drivers/memory/Makefile                            |   1 +
 drivers/memory/brcmstb_dpfe.c                      | 722 ++++++++++++++++++
 drivers/memory/omap-gpmc.c                         |  54 +-
 drivers/of/of_reserved_mem.c                       |  26 +
 drivers/of/platform.c                              |  19 +-
 drivers/reset/Kconfig                              |  30 +-
 drivers/reset/Makefile                             |   5 +-
 drivers/reset/reset-axs10x.c                       |  83 +++
 drivers/reset/reset-meson.c                        |  65 +-
 drivers/reset/reset-simple.c                       | 186 +++++
 drivers/reset/reset-simple.h                       |  45 ++
 drivers/reset/reset-socfpga.c                      | 154 ----
 drivers/reset/reset-stm32.c                        | 108 ---
 drivers/reset/reset-sunxi.c                        | 104 +--
 drivers/reset/reset-uniphier.c                     |  30 +
 drivers/reset/reset-zx2967.c                       |  99 ---
 drivers/soc/Makefile                               |   2 +-
 drivers/soc/amlogic/Kconfig                        |  21 +
 drivers/soc/amlogic/Makefile                       |   2 +
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c            | 243 ++++++
 drivers/soc/amlogic/meson-mx-socinfo.c             | 175 +++++
 drivers/soc/atmel/soc.c                            |   8 +
 drivers/soc/atmel/soc.h                            |   4 +
 drivers/soc/bcm/Kconfig                            |   2 +
 drivers/soc/bcm/brcmstb/Kconfig                    |  10 +
 drivers/soc/bcm/brcmstb/Makefile                   |   1 +
 drivers/soc/bcm/brcmstb/pm/Makefile                |   3 +
 drivers/soc/bcm/brcmstb/pm/aon_defs.h              | 113 +++
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                | 822 +++++++++++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm-mips.c               | 461 ++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm.h                    |  89 +++
 drivers/soc/bcm/brcmstb/pm/s2-arm.S                |  76 ++
 drivers/soc/bcm/brcmstb/pm/s2-mips.S               | 200 +++++
 drivers/soc/bcm/brcmstb/pm/s3-mips.S               | 146 ++++
 drivers/soc/fsl/guts.c                             |   1 +
 drivers/soc/fsl/qbman/Kconfig                      |   2 +-
 drivers/soc/fsl/qbman/Makefile                     |   2 +-
 drivers/soc/fsl/qbman/bman.c                       |  42 +-
 drivers/soc/fsl/qbman/bman_ccsr.c                  |  15 +
 drivers/soc/fsl/qbman/bman_portal.c                |  23 +-
 drivers/soc/fsl/qbman/bman_priv.h                  |   8 +-
 drivers/soc/fsl/qbman/dpaa_sys.c                   |  78 ++
 drivers/soc/fsl/qbman/dpaa_sys.h                   |  25 +-
 drivers/soc/fsl/qbman/qman.c                       |  83 ++-
 drivers/soc/fsl/qbman/qman_ccsr.c                  |  95 ++-
 drivers/soc/fsl/qbman/qman_portal.c                |  23 +-
 drivers/soc/fsl/qbman/qman_priv.h                  |  11 +-
 drivers/soc/fsl/qbman/qman_test.h                  |   2 -
 drivers/soc/mediatek/Kconfig                       |   8 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 511 +++++++++++--
 drivers/soc/qcom/Kconfig                           |  11 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rmtfs_mem.c                       | 269 +++++++
 drivers/soc/qcom/smem.c                            | 335 +++++++--
 drivers/soc/renesas/Kconfig                        |   8 +-
 drivers/soc/renesas/Makefile                       |   1 +
 drivers/soc/renesas/r8a77970-sysc.c                |  39 +
 drivers/soc/renesas/rcar-rst.c                     |   1 +
 drivers/soc/renesas/rcar-sysc.c                    |   3 +
 drivers/soc/renesas/rcar-sysc.h                    |   1 +
 drivers/soc/renesas/renesas-soc.c                  |   8 +
 drivers/soc/samsung/exynos-pmu.c                   |   9 -
 drivers/soc/samsung/exynos-pmu.h                   |   2 -
 drivers/soc/samsung/exynos4-pmu.c                  |  13 +-
 drivers/soc/tegra/powergate-bpmp.c                 |  15 +-
 drivers/thermal/Makefile                           |   2 +-
 drivers/thermal/tegra/Kconfig                      |   7 +
 drivers/thermal/tegra/Makefile                     |   3 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c         | 263 +++++++
 include/dt-bindings/clock/tegra210-car.h           |   1 +
 include/dt-bindings/reset/mt7622-reset.h           |  94 +++
 .../dt-bindings/thermal/tegra186-bpmp-thermal.h    |  14 +
 include/linux/of_reserved_mem.h                    |   5 +
 include/linux/omap-gpmc.h                          |  12 -
 include/linux/platform_data/mtd-nand-omap2.h       |   2 -
 include/linux/qcom_scm.h                           |   4 +
 include/linux/ts-nbus.h                            |  18 +
 include/soc/tegra/bpmp.h                           |  59 +-
 113 files changed, 6980 insertions(+), 993 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.txt
 create mode 100644
Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
 create mode 100644
Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
 create mode 100644
Documentation/devicetree/bindings/reset/snps,axs10x-reset.txt
 create mode 100644
Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
 create mode 100644 drivers/bus/ts-nbus.c
 create mode 100644 drivers/clk/bcm/clk-hr2.c
 create mode 100644 drivers/firmware/tegra/bpmp-debugfs.c
 create mode 100644 drivers/memory/brcmstb_dpfe.c
 create mode 100644 drivers/reset/reset-axs10x.c
 create mode 100644 drivers/reset/reset-simple.c
 create mode 100644 drivers/reset/reset-simple.h
 delete mode 100644 drivers/reset/reset-socfpga.c
 delete mode 100644 drivers/reset/reset-stm32.c
 delete mode 100644 drivers/reset/reset-zx2967.c
 create mode 100644 drivers/soc/amlogic/meson-gx-pwrc-vpu.c
 create mode 100644 drivers/soc/amlogic/meson-mx-socinfo.c
 create mode 100644 drivers/soc/bcm/brcmstb/Kconfig
 create mode 100644 drivers/soc/bcm/brcmstb/pm/Makefile
 create mode 100644 drivers/soc/bcm/brcmstb/pm/aon_defs.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-arm.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-mips.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-arm.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-mips.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s3-mips.S
 create mode 100644 drivers/soc/fsl/qbman/dpaa_sys.c
 create mode 100644 drivers/soc/qcom/rmtfs_mem.c
 create mode 100644 drivers/soc/renesas/r8a77970-sysc.c
 create mode 100644 drivers/thermal/tegra/tegra-bpmp-thermal.c
 create mode 100644 include/dt-bindings/reset/mt7622-reset.h
 create mode 100644 include/dt-bindings/thermal/tegra186-bpmp-thermal.h
 create mode 100644 include/linux/ts-nbus.h
