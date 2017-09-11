From: olof@lixom.net (Olof Johansson)
Date: Sun, 10 Sep 2017 18:18:02 -0700
Subject: [GIT PULL 2/3] ARM: SoC driver updates for v4.14
In-Reply-To: <1505092683-19362-1-git-send-email-olof@lixom.net>
References: <1505092683-19362-1-git-send-email-olof@lixom.net>
Message-ID: <1505092683-19362-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains platform-related driver updates for ARM and ARM64.

Among them:

- Reset driver updates:
+ New API for dealing with arrays of resets
+ Make unimplemented {de,}assert return success on shared resets
+ MSDKv1 driver
+ Removal of obsolete Gemini reset driver
+ Misc updates for sunxi and Uniphier

- SoC drivers:
+ Platform SoC driver registration on Tegra
+ Shuffle of Qualcomm drivers into a submenu
+ Allwinner A64 support for SRAM
+ Renesas R-Car R3 support
+ Power domains for Rockchip RK3366

- Misc updates and smaller fixes for TEE and memory driver subsystems

Conflicts:
drivers/soc/qcom/Kconfig: Add/add conflict. Add new option under the menu.

----------------------------------------------------------------

The following changes since commit 319b36373008cb2a8e163f1d95b738c57c1fa043:

  Merge tag 'armsoc-platforms' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to a48a7b6b54927159bac77735df00e5b9fc3415fb:

  Merge tag 'scpi-fixes-4.14' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into next/drivers

----------------------------------------------------------------

Arnd Bergmann (12):
      Merge tag 'tee-drv-for-4.14' of http://git.linaro.org/people/jens.wiklander/linux-tee into next/drivers
      Merge tag 'v4.14-rockchip-drivers-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'qcom-drivers-for-4.14' of git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'renesas-drivers-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'amlogic-drivers' of git://git.kernel.org/.../khilman/linux-amlogic into next/drivers
      Merge tag 'v4.13-next-soc' of https://github.com/mbgg/linux-mediatek into next/drivers
      Merge tag 'tegra-for-4.14-soc' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.14-firmware' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'reset-for-4.14' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'sunxi-drivers-for-4.14' of https://git.kernel.org/.../sunxi/linux into next/drivers
      Merge tag 'samsung-drivers-4.14-2' of git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'scpi-fixes-4.14' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers

Arvind Yadav (3):
      reset: zx2967: constify zx2967_reset_ops.
      soc: mtk-pmic-wrap: make of_device_ids const.
      tee: tee_shm: Constify dma_buf_ops structures.

Bhumika Goyal (1):
      tee: optee: add const to tee_driver_ops and tee_desc structures

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Use request_firmware_into_buf()

Chen Zhong (1):
      soc: mediatek: add header files required for MT7622 SCPSYS dt-binding

David Wang (1):
      tee: optee: sync with new naming of interrupts

Elaine Zhang (3):
      dt-bindings: power: add RK3366 SoCs header for power-domain
      dt-bindings: add binding for rk3366 power domains
      soc: rockchip: power-domain: add power domain support for rk3366

Eugeniy Paltsev (1):
      ARC: reset: introduce HSDKv1 reset driver

Geert Uytterhoeven (4):
      soc: renesas: Identify R-Car D3
      soc: renesas: Add r8a77995 SYSC PM Domain Binding Definitions
      soc: renesas: rcar-sysc: Add support for R-Car D3 power areas
      soc: renesas: rcar-rst: Add support for R-Car D3

Heiko Stuebner (1):
      Merge branch 'v4.14-shared/pdids' into v4.14-armsoc/drivers

Icenowy Zheng (4):
      dt-bindings: add binding for Allwinner A64 SRAM controller and SRAM C
      drivers: soc: sunxi: fix error processing on base address when claiming
      drivers: soc: sunxi: add support for remapping func value to reg value
      drivers: soc: sunxi: add support for A64 and its SRAM C

Jagan Teki (1):
      bus: sunxi-rsb: Enable by default for ARM64

Jens Wiklander (2):
      tee: optee: fix uninitialized symbol 'parg'
      tee: indicate privileged dev in gen_caps

Jerome Forissier (1):
      tee: add forward declaration for struct device

Katsuhiro Suzuki (3):
      reset: uniphier: add audio systems reset control
      reset: uniphier: add video input subsystem reset control
      reset: uniphier: add analog amplifiers reset control

Linus Walleij (1):
      Revert "reset: Add a Gemini reset controller"

Masahiro Yamada (2):
      reset: uniphier: remove sLD3 SoC support
      reset: uniphier: do not use per-SoC macro for system reset block

Neil Armstrong (2):
      dt-bindings: arm: amlogic: Add SoC information bindings
      soc: Add Amlogic SoC Information driver

Philipp Zabel (2):
      reset: make (de)assert report success for self-deasserting reset drivers
      reset: sunxi: fix number of reset lines

Rob Clark (2):
      soc: qcom: smsm: fix of_node refcnting problem
      soc: qcom: wcnss_ctrl: add missing MODULE_DEVICE_TABLE()

Rob Herring (5):
      soc: samsung: Use kbasename instead of open coding
      firmware: Convert to using %pOF instead of full_name
      bus: Convert to using %pOF instead of full_name
      soc: Convert to using %pOF instead of full_name
      memory: Convert to using %pOF instead of full_name

Sean Wang (4):
      ARM: mediatek: add MT7623a smp bringup code
      dt-bindings: soc: update the binding document for SCPSYS on MediaTek MT7622 SoC
      soc: mediatek: reduce code duplication of scpsys_probe across all SoCs
      soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC

Shawn Lin (1):
      soc: rockchip: disable jtag switching for RK3328 Soc

Srinivas Kandagatla (1):
      soc: qcom: bring all qcom drivers into a submenu

Sudeep Holla (1):
      firmware: arm_scpi: fix endianness of dev_id in struct dev_pstate_set

Thierry Reding (3):
      soc/tegra: Register SoC device
      soc/tegra: Restrict SoC device registration to Tegra
      soc/tegra: fuse: Add missing semi-colon

Timo Alho (1):
      firmware: tegra: set drvdata earlier

Tuomas Tynkkynen (1):
      soc/tegra: Fix bad of_node_put() in powergate init

Vivek Gautam (1):
      reset: Add APIs to manage array of resets

tiger-yu99 (1):
      tee: optee: interruptible RPC sleep


 .../devicetree/bindings/arm/amlogic.txt         |  29 +++
 .../bindings/power/renesas,rcar-sysc.txt        |   1 +
 .../devicetree/bindings/reset/renesas,rst.txt   |   1 +
 .../bindings/reset/uniphier-reset.txt           |  27 +-
 .../devicetree/bindings/soc/mediatek/scpsys.txt |   3 +
 .../bindings/soc/rockchip/power_domain.txt      |   3 +
 .../devicetree/bindings/sram/sunxi-sram.txt     |   9 +-
 MAINTAINERS                                     |   7 +
 arch/arm/mach-mediatek/mediatek.c               |   2 +
 arch/arm/mach-mediatek/platsmp.c                |   1 +
 arch/arm/mach-tegra/tegra.c                     |  29 +--
 drivers/bus/Kconfig                             |   2 +-
 drivers/bus/arm-cci.c                           |  12 +-
 drivers/bus/imx-weim.c                          |   8 +-
 drivers/bus/sunxi-rsb.c                         |  22 +-
 drivers/firmware/arm_scpi.c                     |   4 +-
 drivers/firmware/psci.c                         |   4 +-
 drivers/firmware/tegra/bpmp.c                   |   4 +-
 drivers/memory/atmel-ebi.c                      |  17 +-
 drivers/memory/jz4780-nemc.c                    |  12 +-
 drivers/memory/mvebu-devbus.c                   |  12 +-
 drivers/memory/omap-gpmc.c                      |  16 +-
 drivers/reset/Kconfig                           |   9 +-
 drivers/reset/Makefile                          |   2 +-
 drivers/reset/core.c                            | 238 +++++++++++++++++-
 drivers/reset/reset-gemini.c                    | 110 ---------
 drivers/reset/reset-hsdk-v1.c                   | 137 ++++++++++
 drivers/reset/reset-sunxi.c                     |   4 +-
 drivers/reset/reset-uniphier.c                  | 117 ++++-----
 drivers/reset/reset-zx2967.c                    |   2 +-
 drivers/soc/Kconfig                             |   1 +
 drivers/soc/Makefile                            |   1 +
 drivers/soc/amlogic/Kconfig                     |  12 +
 drivers/soc/amlogic/Makefile                    |   1 +
 drivers/soc/amlogic/meson-gx-socinfo.c          | 177 +++++++++++++
 drivers/soc/fsl/qbman/bman_ccsr.c               |  10 +-
 drivers/soc/fsl/qbman/bman_portal.c             |   8 +-
 drivers/soc/fsl/qbman/qman_ccsr.c               |  12 +-
 drivers/soc/fsl/qbman/qman_portal.c             |  11 +-
 drivers/soc/fsl/qe/gpio.c                       |   4 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c            |  10 +-
 drivers/soc/mediatek/mtk-scpsys.c               | 247 +++++++++++--------
 drivers/soc/qcom/Kconfig                        |   4 +
 drivers/soc/qcom/mdt_loader.c                   |   5 +-
 drivers/soc/qcom/smsm.c                         |   3 +-
 drivers/soc/qcom/wcnss_ctrl.c                   |   1 +
 drivers/soc/renesas/Kconfig                     |   7 +-
 drivers/soc/renesas/Makefile                    |   1 +
 drivers/soc/renesas/r8a77995-sysc.c             |  31 +++
 drivers/soc/renesas/rcar-rst.c                  |   5 +-
 drivers/soc/renesas/rcar-sysc.c                 |   9 +-
 drivers/soc/renesas/rcar-sysc.h                 |   1 +
 drivers/soc/renesas/renesas-soc.c               |   8 +
 drivers/soc/rockchip/grf.c                      |  14 ++
 drivers/soc/rockchip/pm_domains.c               |  32 +++
 drivers/soc/samsung/pm_domains.c                |  10 +-
 drivers/soc/sunxi/sunxi_sram.c                  |  57 ++++-
 drivers/soc/tegra/Kconfig                       |   5 +
 drivers/soc/tegra/fuse/fuse-tegra.c             |  56 ++++-
 drivers/soc/tegra/pmc.c                         |   4 +-
 drivers/tee/optee/core.c                        |  19 +-
 drivers/tee/optee/optee_smc.h                   |  12 +-
 drivers/tee/optee/rpc.c                         |  15 +-
 drivers/tee/tee_core.c                          |   5 +
 drivers/tee/tee_shm.c                           |   2 +-
 include/dt-bindings/power/mt7622-power.h        |  22 ++
 include/dt-bindings/power/r8a77995-sysc.h       |  23 ++
 include/dt-bindings/power/rk3366-power.h        |  24 ++
 include/dt-bindings/reset/snps,hsdk-v1-reset.h  |  17 ++
 include/linux/reset.h                           |  68 +++++
 include/linux/soc/mediatek/infracfg.h           |   7 +
 include/linux/tee_drv.h                         |   1 +
 include/soc/tegra/fuse.h                        |   2 +
 include/uapi/linux/tee.h                        |   1 +
 74 files changed, 1347 insertions(+), 462 deletions(-)
 delete mode 100644 drivers/reset/reset-gemini.c
 create mode 100644 drivers/reset/reset-hsdk-v1.c
 create mode 100644 drivers/soc/amlogic/Kconfig
 create mode 100644 drivers/soc/amlogic/Makefile
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo.c
 create mode 100644 drivers/soc/renesas/r8a77995-sysc.c
 create mode 100644 include/dt-bindings/power/mt7622-power.h
 create mode 100644 include/dt-bindings/power/r8a77995-sysc.h
 create mode 100644 include/dt-bindings/power/rk3366-power.h
 create mode 100644 include/dt-bindings/reset/snps,hsdk-v1-reset.h
