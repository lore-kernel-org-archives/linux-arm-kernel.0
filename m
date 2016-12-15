From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 00:10:13 +0100
Subject: [GIT PULL 7/7] ARM: SoC driver updates for v4.10
In-Reply-To: <2664636.Hf0nvRznEK@wuerfel>
References: <2664636.Hf0nvRznEK@wuerfel>
Message-ID: <3484127.qQQDAIArAO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit da65a1589dacc7ec44ea0557a14d70a39d991f32:

  base: soc: Provide a dummy implementation of soc_device_match() (2016-11-10 10:10:37 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to 2ada9593224ccc0f6a9368778dc55a59b92aff10:

  Merge tag 'qcom-drivers-for-4.10-2' of git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux into next/drivers (2016-11-30 22:49:14 +0100)

----------------------------------------------------------------
ARM: SoC driver updates for v4.10

Driver updates for ARM SoCs, including a couple of newly added drivers:

- A new driver for the power management controller on TI Keystone
- Support for the prerelease "SCPI" firmware protocol that ended up
  being shipped by Amlogic in their GXBB SoC.
- A soc_device can now be matched using a glob from inside the
  kernel, when another driver wants to know the specific chip
  it is running on and cannot find out from DT, firmware or hardware.
- Renesas SoCs now support identification through the soc_device
  interface, both in user space and kernel.
- Renesas r8a7743 and r8a7745 gain support for their system controller
- A new checking module for the ARM "PSCI" (not to be confused
  with "SCPI" mentioned above) firmware interface.
- A new driver for the Tegra GMI memory interface
- Support for the Tegra firmware interfaces with their
  power management controllers

As usual, the updates for the reset controller framework are merged
here, as they tend to touch multiple SoCs as well, including a new
driver for the Oxford (now Broadcom) OX820 chip and the Tegra
bpmp interface.

The existing drivers for Atmel, Qualcomm, NVIDIA, TI Davinci, and
Rockchips SoCs see some further updates.

Conflicts:
- ARCH_RENESAS now selects SOC_BUS, but no longer needs GPIOLIB
- drivers/soc/renesas/Makefile: multiple files got added, keep
  all in logical sorting

----------------------------------------------------------------
Alexandre Belloni (4):
      Documentation: dt: atmel-at91: Document secumod bindings
      ARM: at91: add secumod register definitions
      misc: sram: document new compatible
      misc: sram: add Atmel securam support

Andy Gross (1):
      Merge tag 'qcom-drivers-for-4.10' into drivers-for-4.10-2

Arnd Bergmann (8):
      Merge tag 'davinci-for-v4.10/drivers-2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/drivers
      misc: sram: remove useless #ifdef
      Merge tag 'renesas-r8a7745-sysc-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'soc-device-match-tag1' of git://git.kernel.org/.../geert/renesas-drivers into next/drivers
      Merge tag 'renesas-soc-match-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'scpi-updates-4.10' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge branch 'for-4.10-ti-sci-base' of https://github.com/t-kristo/linux-pm into next/drivers
      Merge tag 'qcom-drivers-for-4.10-2' of git://git.kernel.org/.../agross/linux into next/drivers

Bartosz Golaszewski (4):
      memory: davinci: add support for da8xx DDR2/mDDR controller
      bus: davinci: add support for da8xx bus master priority control
      bus: da8xx-mstpri: drop the call to of_flat_dt_get_machine_name()
      memory: da8xx-ddrctl: drop the call to of_flat_dt_get_machine_name()

Bjorn Andersson (1):
      soc: qcom: wcnss_ctrl: Stub wcnss_ctrl API

Caesar Wang (1):
      soc: rockchip: power-domain: avoid infinite loop

Dan Carpenter (1):
      mailbox: tegra-hsp: Use after free in tegra_hsp_remove_doorbells()

Douglas Anderson (1):
      soc: rockchip: power-domain: Don't (incorrectly) set rk3399 up/down counts

Geert Uytterhoeven (2):
      ARM: shmobile: Document DT bindings for Product Register
      soc: renesas: Identify SoC and register with the SoC bus

Heiko Stuebner (1):
      soc: rockchip: power-domain: use pm_genpd_remove in error cleanup

James Liao (1):
      soc: mediatek: Refine scpsys to support multiple platform

Jon Hunter (4):
      soc/tegra: pmc: Guard against uninitialised PMC clock
      soc/tegra: pmc: Simplify IO rail bit handling
      soc/tegra: pmc: Check return code for pm_genpd_init()
      soc/tegra: pmc: Remove genpd when adding provider fails

Joseph Lo (3):
      soc/tegra: Add Tegra186 support
      dt-bindings: mailbox: Add Tegra HSP binding
      dt-bindings: firmware: Add bindings for Tegra BPMP

Kevin Brodsky (1):
      drivers: psci: PSCI checker module

Laxman Dewangan (3):
      soc/tegra: pmc: Use BIT macro for register field definition
      soc/tegra: pmc: Correct type of variable for tegra_pmc_readl()
      soc/tegra: pmc: Add I/O pad voltage support

Martin Blumenstingl (1):
      reset: allow using reset_control_reset with shared reset

Michael Scott (1):
      MAINTAINERS: add drivers/pinctrl/qcom to ARM/QUALCOMM SUPPORT

Mirza Krak (2):
      dt/bindings: Add bindings for Tegra GMI controller
      bus: Add support for Tegra Generic Memory Interface

Neil Armstrong (7):
      reset: oxnas: Add OX820 support
      dt-bindings: reset: oxnas: Add include file with reset indexes
      dt-bindings: reset: oxnas: Update for OX820
      firmware: arm_scpi: increase MAX_DVFS_OPPS to 16 entries
      firmware: arm_scpi: add alternative legacy structures, functions and macros
      firmware: arm_scpi: allow firmware with get_capabilities not implemented
      Documentation: bindings: Add support for Amlogic GXBB SCPI protocol

Nishanth Menon (5):
      Documentation: Add support for TI System Control Interface (TI-SCI) protocol
      firmware: Add basic support for TI System Control Interface (TI-SCI) protocol
      firmware: ti_sci: Add support for Device control
      firmware: ti_sci: Add support for Clock control
      firmware: ti_sci: Add support for reboot core service

Olof Johansson (12):
      Merge tag 'renesas-drivers-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'v4.10-rockchip-drivers1' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'qcom-drivers-for-4.10' of git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'davinci-for-v4.10/drivers' of git://git.kernel.org/.../nsekhar/linux-davinci into next/drivers
      Merge tag 'v4.9-next-soc' of https://github.com/mbgg/linux-mediatek into next/drivers
      Merge tag 'at91-ab-4.10-drivers' of git://git.kernel.org/.../abelloni/linux into next/drivers
      Merge tag 'reset-for-4.10' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'tegra-for-4.10-mailbox' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.10-firmware' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.10-reset' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.10-bus' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.10-soc' of git://git.kernel.org/.../tegra/linux into next/drivers

Paul Gortmaker (5):
      reset: berlin: make it explicitly non-modular
      reset: socfpga: make it explicitly non-modular
      reset: sunxi: make it explicitly non-modular
      reset: zynq: make it explicitly non-modular
      reset: lpc18xx: make it explicitly non-modular

Peter Griffin (2):
      reset: sti: Remove STiH415/6 reset support
      reset: sti: softreset: Remove obsolete platforms from dt binding doc.

Sergei Shtylyov (4):
      ARM: shmobile: r8a7743: add power domain index macros
      soc: renesas: rcar-sysc: add R8A7743 support
      ARM: shmobile: r8a7745: add power domain index macros
      soc: renesas: rcar-sysc: add R8A7745 support

Shunli Wang (1):
      soc: mediatek: Add MT2701 scpsys driver

Srinivas Kandagatla (1):
      pinctrl: pm8994: add pad voltage regulator defines

Stephen Warren (2):
      dt-bindings: Add power domains to Tegra BPMP firmware
      dt-bindings: firmware: Allow child nodes inside the Tegra BPMP

Sudeep Holla (4):
      firmware: arm_scpi: add command indirection to support legacy commands
      Documentation: bindings: decouple juno specific details from generic binding
      Documentation: bindings: add compatible specific to pre v1.0 SCPI protocols
      firmware: arm_scpi: add support for pre-v1.0 SCPI compatible

Thierry Reding (11):
      soc/tegra: pmc: Use consistent ordering of bit definitions
      soc/tegra: pmc: Clean-up I/O rail error messages
      soc/tegra: pmc: Use consistent naming for PM domains
      Merge branch 'for-4.10/soc' into for-4.10/mailbox
      mailbox: Add Tegra HSP driver
      Merge branch 'for-4.10/mailbox' into for-4.10/firmware
      firmware: tegra: Add IVC library
      firmware: tegra: Add BPMP support
      Merge branch 'for-4.10/firmware' into for-4.10/reset
      reset: Add Tegra BPMP reset driver
      drivers: psci: Allow PSCI node to be disabled

Tomeu Vizoso (1):
      soc: rockchip: power-domain: Handle errors from of_genpd_add_provider_onecell

Wei Yongjun (3):
      memory: atmel-ebi: fix return value check in at91_ebi_dev_disable()
      memory: atmel-sdramc: use builtin_platform_driver to simplify the code
      firmware: qcom: scm: Use devm_reset_controller_register()

spjoshi at codeaurora.org (3):
      dt-bindings: firmware: scm: Add MSM8996 DT bindings
      firmware: qcom: scm: Remove core, iface and bus clocks dependency
      firmware: qcom: scm: Return PTR_ERR when devm_clk_get fails

 .../devicetree/bindings/arm/amlogic,scpi.txt       |   20 +
 Documentation/devicetree/bindings/arm/arm,scpi.txt |   25 +-
 .../devicetree/bindings/arm/atmel-at91.txt         |   16 +
 .../devicetree/bindings/arm/juno,scpi.txt          |   26 +
 .../devicetree/bindings/arm/keystone/ti,sci.txt    |   81 +
 Documentation/devicetree/bindings/arm/shmobile.txt |   18 +
 .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt |  132 ++
 .../devicetree/bindings/bus/ti,da850-mstpri.txt    |   20 +
 .../bindings/firmware/nvidia,tegra186-bpmp.txt     |  108 ++
 .../devicetree/bindings/firmware/qcom,scm.txt      |    2 +
 .../bindings/mailbox/nvidia,tegra186-hsp.txt       |   52 +
 .../memory-controllers/ti-da8xx-ddrctl.txt         |   20 +
 .../bindings/power/renesas,rcar-sysc.txt           |    8 +-
 .../devicetree/bindings/reset/oxnas,reset.txt      |   44 +-
 Documentation/devicetree/bindings/sram/sram.txt    |    2 +-
 MAINTAINERS                                        |   11 +
 arch/arm/mach-shmobile/Kconfig                     |    1 +
 arch/arm/mach-sti/Kconfig                          |    2 -
 arch/arm64/Kconfig.platforms                       |    1 +
 drivers/bus/Kconfig                                |   16 +
 drivers/bus/Makefile                               |    3 +
 drivers/bus/da8xx-mstpri.c                         |  267 +++
 drivers/bus/tegra-gmi.c                            |  284 +++
 drivers/firmware/Kconfig                           |   27 +
 drivers/firmware/Makefile                          |    3 +
 drivers/firmware/arm_scpi.c                        |  276 ++-
 drivers/firmware/psci.c                            |    2 +-
 drivers/firmware/psci_checker.c                    |  490 +++++
 drivers/firmware/qcom_scm.c                        |   53 +-
 drivers/firmware/tegra/Kconfig                     |   25 +
 drivers/firmware/tegra/Makefile                    |    2 +
 drivers/firmware/tegra/bpmp.c                      |  868 +++++++++
 drivers/firmware/tegra/ivc.c                       |  695 +++++++
 drivers/firmware/ti_sci.c                          | 1991 ++++++++++++++++++++
 drivers/firmware/ti_sci.h                          |  492 +++++
 drivers/mailbox/Kconfig                            |    9 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/tegra-hsp.c                        |  479 +++++
 drivers/memory/Kconfig                             |    8 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/atmel-ebi.c                         |    2 +-
 drivers/memory/atmel-sdramc.c                      |    6 +-
 drivers/memory/da8xx-ddrctl.c                      |  173 ++
 drivers/misc/sram.c                                |   42 +-
 drivers/reset/Kconfig                              |    1 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/core.c                               |   43 +-
 drivers/reset/reset-berlin.c                       |   12 +-
 drivers/reset/reset-lpc18xx.c                      |   32 +-
 drivers/reset/reset-oxnas.c                        |    1 +
 drivers/reset/reset-socfpga.c                      |   10 +-
 drivers/reset/reset-sunxi.c                        |    9 +-
 drivers/reset/reset-zynq.c                         |   10 +-
 drivers/reset/sti/Kconfig                          |    8 -
 drivers/reset/sti/Makefile                         |    2 -
 drivers/reset/sti/reset-stih415.c                  |  112 --
 drivers/reset/sti/reset-stih416.c                  |  143 --
 drivers/reset/tegra/Kconfig                        |    2 +
 drivers/reset/tegra/Makefile                       |    1 +
 drivers/reset/tegra/reset-bpmp.c                   |   71 +
 drivers/soc/mediatek/Kconfig                       |    2 +-
 drivers/soc/mediatek/mtk-scpsys.c                  |  465 +++--
 drivers/soc/renesas/Makefile                       |    4 +
 drivers/soc/renesas/r8a7743-sysc.c                 |   32 +
 drivers/soc/renesas/r8a7745-sysc.c                 |   32 +
 drivers/soc/renesas/rcar-sysc.c                    |    6 +
 drivers/soc/renesas/rcar-sysc.h                    |    2 +
 drivers/soc/renesas/renesas-soc.c                  |  257 +++
 drivers/soc/rockchip/pm_domains.c                  |   81 +-
 drivers/soc/tegra/Kconfig                          |   14 +
 drivers/soc/tegra/pmc.c                            |  398 +++-
 include/dt-bindings/clock/tegra186-clock.h         |  940 +++++++++
 include/dt-bindings/mailbox/tegra186-hsp.h         |   24 +
 include/dt-bindings/pinctrl/qcom,pmic-gpio.h       |    4 +
 include/dt-bindings/pinctrl/qcom,pmic-mpp.h        |    6 +
 include/dt-bindings/power/tegra186-powergate.h     |   39 +
 include/dt-bindings/reset/oxsemi,ox810se.h         |   53 +
 include/dt-bindings/reset/oxsemi,ox820.h           |   53 +
 include/dt-bindings/reset/tegra186-reset.h         |  217 +++
 include/linux/soc/qcom/wcnss_ctrl.h                |   13 +
 include/linux/soc/ti/ti_sci_protocol.h             |  249 +++
 include/soc/at91/atmel-secumod.h                   |   19 +
 include/soc/tegra/bpmp-abi.h                       | 1601 ++++++++++++++++
 include/soc/tegra/bpmp.h                           |  141 ++
 include/soc/tegra/ivc.h                            |  109 ++
 include/soc/tegra/pmc.h                            |  126 +-
 86 files changed, 11428 insertions(+), 722 deletions(-)
