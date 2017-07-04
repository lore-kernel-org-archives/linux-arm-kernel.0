From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jul 2017 16:24:42 +0200
Subject: [GIT PULL 5/7] ARM: SoC driver updates
Message-ID: <CAK8P3a0Pizf3ZBjG7Sn2BB_g+wtewz-CtJnOU5voONGvWS=EGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-drivers

for you to fetch changes up to ffe3744a591fdce695da6b891378261e2caedc69:

  Merge tag 'actions-drivers-for-4.13' of
git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions
into next/drivers (2017-06-29 17:34:57 +0200)

----------------------------------------------------------------
ARM: SoC driver updates

- New SoC specific drivers
  - NVIDIA Tegra PM Domain support for newer SoCs (Tegra186 and later)
    based on the "BPMP" firmware
  - Clocksource and system controller drivers for the newly added
    Action Semi platforms (both arm and arm64).

- Reset subsystem, merged through arm-soc by tradition:
  - New drivers for Altera Stratix10, TI Keystone and Cortina Gemini SoCs
  - Various subsystem-wide cleanups

- Updates for existing SoC-specific drivers
  - TI GPMC (General Purpose Memory Controller)
  - Mediatek "scpsys" system controller support for MT6797
  - Broadcom "brcmstb_gisb" bus arbitrer
  - ARM SCPI firmware
  - Renesas "SYSC" system controller

One more driver update was submitted for the Freescale/NXP DPAA
data path acceleration that has previously been used on PowerPC
chips. I ended up postponing the merge until some API questions
for its unusual MMIO access are resolved.

----------------------------------------------------------------
Andreas F?rber (6):
      clocksource: Add Owl timer
      clocksource: owl: Add S900 support
      dt-bindings: power: Add Owl SPS power domains
      soc: actions: Add Owl SPS
      soc: actions: owl-sps: Factor out owl_sps_set_pg() for power-gating
      Merge branch 'v4.13/sps' into v4.13/drivers

Andrew F. Davis (2):
      dt-bindings: reset: Add TI SCI reset binding
      reset: Add the TI SCI reset driver

Arnd Bergmann (2):
      Merge tag 'qcom-drivers-for-4.13' of
git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'actions-drivers-for-4.13' of
git://git.kernel.org/.../afaerber/linux-actions into next/drivers

Christophe Jaillet (2):
      soc: mediatek: PMIC wrap: Fix error handling
      soc/tegra: flowctrl: Fix error handling

Dan Carpenter (1):
      firmware: tegra: Fix locking bugs in BPMP

Doug Berger (6):
      bus: brcmstb_gisb: Use register offsets with writes too
      bus: brcmstb_gisb: correct support for 64-bit address output
      bus: brcmstb_gisb: add notifier handling
      bus: brcmstb_gisb: remove low-level ARM hooks
      bus: brcmstb_gisb: enable driver for ARM64 architecture
      bus: brcmstb_gisb: update to support new revision

Geert Uytterhoeven (2):
      soc: renesas: Rework Kconfig and Makefile logic
      soc: renesas: rcar-sysc: Use GENPD_FLAG_ALWAYS_ON

Jonathan Neusch?fer (1):
      soc: qcom: smsm: Improve error handling, quiesce probe deferral

Linus Walleij (2):
      reset: add DT bindings header for Gemini reset controller
      reset: Add a Gemini reset controller

Marc Ohlf (1):
      soc: imx: gpc: build gpc only if hardware has gpc

Markus Elfring (1):
      reset: sti: Use devm_kcalloc() in syscfg_reset_controller_register()

Markus Mayer (1):
      soc: brcmstb: enable drivers for ARM64 and BMIPS

Mars Cheng (3):
      soc: mediatek: avoid using fixed spm power status defines
      soc: mediatek: add vdec item for scpsys
      soc: mediatek: add MT6797 scpsys support

Olof Johansson (11):
      Merge tag 'omap-for-v4.13/gpmc-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/drivers
      Merge tag 'reset-for-4.13' of
git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'reset-for-4.13-2' of
git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'v4.12-next-soc' of
https://github.com/mbgg/linux-mediatek into next/drivers
      Merge tag 'arm-soc/for-4.13/drivers' of
http://github.com/Broadcom/stblinux into next/drivers
      Merge tag 'scpi-updates-4.13' of
git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'tegra-for-4.13-soc' of
git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.13-firmware' of
git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'renesas-drivers-for-v4.13' of
https://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'renesas-rcar-sysc-for-v4.13' of
https://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'imx-drivers-4.13' of
git://git.kernel.org/.../shawnguo/linux into next/drivers

Philipp Zabel (1):
      reset: use kref for reference counting

Richard Gong (1):
      dt-bindings: reset: Add reset manager offsets for Stratix10

Sudeep Holla (2):
      firmware: arm_scpi: add support to populate OPPs and get
transition latency
      cpufreq: scpi: use new scpi_ops functions to remove duplicate code

Suman Anna (1):
      reset: ti_syscon: Rename TI_SYSCON_RESET to RESET_TI_SYSCON

Thierry Reding (3):
      PM / Domains: Allow overriding the ->xlate() callback
      soc/tegra: bpmp: Update ABI header
      soc/tegra: bpmp: Implement generic PM domains

Uwe Kleine-K?nig (2):
      memory: omap-gpmc: make dts snippet include semicolon
      memory: omap-gpmc: add error message if bank-width property is absent

shailendra.v at samsung.com (1):
      soc: mediatek: PMIC wrap: Fix possible NULL derefrence.

 .../devicetree/bindings/bus/brcm,gisb-arb.txt      |   3 +-
 .../devicetree/bindings/power/actions,owl-sps.txt  |  17 +
 .../devicetree/bindings/reset/ti,sci-reset.txt     |  62 +++
 MAINTAINERS                                        |   2 +
 drivers/base/power/domain.c                        |   8 +-
 drivers/bus/Kconfig                                |   2 +-
 drivers/bus/brcmstb_gisb.c                         | 121 +++---
 drivers/clocksource/Kconfig                        |   7 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/owl-timer.c                    | 172 +++++++++
 drivers/cpufreq/scpi-cpufreq.c                     |  38 +-
 drivers/firmware/arm_scpi.c                        |  63 ++++
 drivers/firmware/tegra/bpmp.c                      |  32 +-
 drivers/memory/omap-gpmc.c                         |   9 +-
 drivers/reset/Kconfig                              |  17 +-
 drivers/reset/Makefile                             |   4 +-
 drivers/reset/core.c                               |  23 +-
 drivers/reset/reset-gemini.c                       | 110 ++++++
 drivers/reset/reset-ti-sci.c                       | 269 +++++++++++++
 drivers/reset/sti/reset-syscfg.c                   |   6 +-
 drivers/soc/Kconfig                                |   2 +
 drivers/soc/Makefile                               |   3 +-
 drivers/soc/actions/Kconfig                        |  16 +
 drivers/soc/actions/Makefile                       |   2 +
 drivers/soc/actions/owl-sps-helper.c               |  51 +++
 drivers/soc/actions/owl-sps.c                      | 224 +++++++++++
 drivers/soc/bcm/Kconfig                            |   2 +-
 drivers/soc/imx/Makefile                           |   2 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c               |  14 +-
 drivers/soc/mediatek/mtk-scpsys.c                  | 149 +++++++-
 drivers/soc/qcom/smsm.c                            |   9 +-
 drivers/soc/renesas/Kconfig                        |  63 ++++
 drivers/soc/renesas/Makefile                       |  31 +-
 drivers/soc/renesas/rcar-sysc.c                    |  52 +--
 drivers/soc/renesas/rcar-sysc.h                    |   2 -
 drivers/soc/tegra/Kconfig                          |   5 +
 drivers/soc/tegra/Makefile                         |   1 +
 drivers/soc/tegra/flowctrl.c                       |   2 +-
 drivers/soc/tegra/powergate-bpmp.c                 | 359 ++++++++++++++++++
 include/dt-bindings/power/mt6797-power.h           |  30 ++
 include/dt-bindings/power/owl-s500-powergate.h     |  19 +
 include/dt-bindings/reset/altr,rst-mgr-s10.h       | 108 ++++++
 include/dt-bindings/reset/cortina,gemini-reset.h   |  36 ++
 include/linux/pm_domain.h                          |   4 +
 include/linux/scpi_protocol.h                      |   3 +
 include/linux/soc/actions/owl-sps.h                |  11 +
 include/linux/soc/renesas/rcar-rst.h               |   3 +-
 include/soc/tegra/bpmp-abi.h                       | 418 ++++++++++++++++++++-
 include/soc/tegra/bpmp.h                           |  12 +
 49 files changed, 2401 insertions(+), 198 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
 create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 create mode 100644 drivers/clocksource/owl-timer.c
 create mode 100644 drivers/reset/reset-gemini.c
 create mode 100644 drivers/reset/reset-ti-sci.c
 create mode 100644 drivers/soc/actions/Kconfig
 create mode 100644 drivers/soc/actions/Makefile
 create mode 100644 drivers/soc/actions/owl-sps-helper.c
 create mode 100644 drivers/soc/actions/owl-sps.c
 create mode 100644 drivers/soc/renesas/Kconfig
 create mode 100644 drivers/soc/tegra/powergate-bpmp.c
 create mode 100644 include/dt-bindings/power/mt6797-power.h
 create mode 100644 include/dt-bindings/power/owl-s500-powergate.h
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-s10.h
 create mode 100644 include/dt-bindings/reset/cortina,gemini-reset.h
 create mode 100644 include/linux/soc/actions/owl-sps.h
