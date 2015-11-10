From: olof@lixom.net (Olof Johansson)
Date: Mon,  9 Nov 2015 19:33:21 -0800
Subject: [GIT PULL 3/6] ARM: SoC platform updates for v4.4
In-Reply-To: <1447126404-10567-1-git-send-email-olof@lixom.net>
References: <1447126404-10567-1-git-send-email-olof@lixom.net>
Message-ID: <1447126404-10567-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New and/or improved SoC support for this release:

- Marvell Berlin:
* Enable standard DT-based cpufreq
* Add CPU hotplug support
- Freescale:
* Ethernet init for i.MX7D
* Suspend/resume support for i.MX6UL
- Allwinner:
* Support for R8 chipset (used on NTC's $9 C.H.I.P board)
- Mediatek:
* SMP support for some platforms
- Uniphier:
* L2 support
* Cleaned up SMP support, etc.

+ A handful of other patches around above functionality, and a few other
smaller changes.


Conflicts:

None, however this is the one where we're supposed to remind you to:

In arch/arm/mach-mediatek/mediatek.c:

> -    clocksource_of_init();
> +    clocksource_probe();

----------------------------------------------------------------

The following changes since commit 4568c7498a97a7b6df66bc6f9268e627929b5d70:

  Merge tag 'armsoc-cleanup' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to b1e4006aeda8c8784029de17d47987c21ea75f6d:

  ARM: uniphier: rework SMP operations to use trampoline code

----------------------------------------------------------------

Alexandre Belloni (3):
      MAINTAINERS: explicitly add Atmel SAMA5
      ARM: at91: remove useless includes in platform_data/atmel.h
      ARM: at91: debug: use DEBUG_UART_PHYS

Andy Shevchenko (1):
      ARM: orion5x: use mac_pton() helper

Anson Huang (1):
      ARM: imx: add suspend/resume support for i.mx6ul

Antoine Tenart (1):
      ARM: berlin: register cpufreq-dt

Arnd Bergmann (8):
      Merge tag 'renesas-soc-for-v4.4' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'at91-soc' of git://git.kernel.org/.../nferre/linux-at91 into next/soc
      Merge tag 'mvebu-soc-4.4-1' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'berlin64-soc-for-4.4-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/soc
      Merge tag 'berlin-soc-for-4.4-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/soc
      Merge tag 'arm-soc/for-4.4/soc' of http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'keystone-driver-soc_v2' of git://git.kernel.org/.../ssantosh/linux-keystone into next/soc
      Merge tag 'berlin-soc-for-4.4-2' of git://git.infradead.org/users/hesselba/linux-berlin into next/soc

Bai Ping (1):
      ARM: imx: add cpufreq device for imx6ul

Baruch Siach (1):
      ARM: digicolor: select pinctrl/gpio driver

Brian Norris (1):
      soc: add stubs for brcmstb SoC's

Carlo Caione (1):
      ARM: meson: Enable Meson8b SoCs

Dmitry Osipenko (1):
      ARM: tegra: paz00: use con_id's to refer GPIO's in gpiod_lookup table

Eddie Huang (1):
      soc: mediatek: add scpsys support active_wakeup

Florian Fainelli (2):
      soc: brcmstb: Add Bus Interface Unit control setup
      ARM: brcmstb: Setup BIU control registers during boot

Fugang Duan (2):
      ARM: imx7d: add imx7d iomux-gpr field define
      ARM: imx: add enet init for i.MX7D platform

Geert Uytterhoeven (2):
      clk: shmobile: mstp: Consider "zb_clk" suitable for power management
      ARM: shmobile: R-Mobile: Use CPG/MSTP Clock Domain attach/detach helpers

Henry Chen (1):
      soc: mediatek: Move the initial setting of pmic wrap interrupt before requesting irq.

James Liao (1):
      soc: mediatek: Fix random hang up issue while kernel init

Jisheng Zhang (3):
      arm64: berlin: enable ARCH_REQUIRE_GPIOLIB
      arm: berlin: use non-self-cleared reset register to reset cpu
      arm: berlin: add CPU hotplug support

Jon Mason (1):
      ARM: NSP: Add basic support for Broadcom Northstar Plus SoC

Krzysztof Kozlowski (1):
      Documentation: EXYNOS: Update bootloader interface on exynos542x

Masahiro Yamada (2):
      ARM: uniphier: add outer cache support
      ARM: uniphier: rework SMP operations to use trampoline code

Matthias Brugger (1):
      ARM: mediatek: enable gpt6 on boot up to make arch timer working

Maxime Ripard (1):
      ARM: sunxi: Add R8 support

Murali Karicheri (3):
      Documentation: dt: soc: Add description for knav qmss driver
      soc: ti: add firmware file name as part of the driver
      soc: ti: qmss: make acc queue support optional in the driver

Olof Johansson (7):
      Merge tag 'sunxi-core-for-4.4' of https://git.kernel.org/.../mripard/linux into next/soc
      Merge tag 'v4.3-next-soc' of https://github.com/mbgg/linux-mediatek into next/soc
      Merge tag 'imx-soc-4.4' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'at91-ab-soc2' of git://git.kernel.org/.../abelloni/linux into next/soc
      Merge tag 'tegra-for-4.4-soc' of git://git.kernel.org/.../tegra/linux into next/soc
      Merge tag 'mvebu-soc-4.4-2' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'samsung-soc' of git://git.kernel.org/.../kgene/linux-samsung into next/soc

Patrick Doyle (1):
      ARM: at91: pm: at91_pm_suspend_in_sram() must be 8-byte aligned

Thierry Reding (6):
      ARM: S3C24XX: Use PWM lookup table for mach-h1940
      ARM: S3C24XX: Use PWM lookup table for mach-rx1950
      ARM: S3C64XX: Use PWM lookup table for smdk6410
      ARM: S3C64XX: Use PWM lookup table for mach-crag6410
      ARM: S3C64XX: Use PWM lookup table for mach-hmt
      ARM: S3C64XX: Use PWM lookup table for mach-smartq

Thomas Petazzoni (1):
      ARM: mvebu: add support to clear shared L2 bit on Armada XP

Vincent Donnefort (1):
      ARM: mvebu: add broken-idle option

Yingjoe Chen (1):
      ARM: mediatek: add smp bringup code


 .../arm/Samsung/Bootloader-interface.txt        |   5 +-
 Documentation/arm/keystone/knav-qmss.txt        |  56 ++
 Documentation/arm/sunxi/README                  |   2 +-
 .../bindings/arm/coherency-fabric.txt           |   5 +
 .../bindings/arm/mvebu-cpu-config.txt           |  20 +
 Documentation/devicetree/bindings/arm/sunxi.txt |   1 +
 .../bindings/arm/uniphier/cache-uniphier.txt    |  60 ++
 .../bindings/soc/ti/keystone-navigator-qmss.txt |   1 -
 MAINTAINERS                                     |   4 +-
 arch/arm/Kconfig.debug                          |  41 +-
 arch/arm/include/asm/hardware/cache-uniphier.h  |  46 ++
 arch/arm/include/debug/at91.S                   |  18 +-
 arch/arm/kernel/irq.c                           |   3 +
 arch/arm/mach-at91/pm_suspend.S                 |   2 +
 arch/arm/mach-bcm/Kconfig                       |  15 +
 arch/arm/mach-bcm/Makefile                      |   5 +-
 arch/arm/mach-bcm/bcm_nsp.c                     |  25 +
 arch/arm/mach-bcm/brcmstb.c                     |   9 +
 arch/arm/mach-berlin/berlin.c                   |   6 +
 arch/arm/mach-berlin/platsmp.c                  |  38 +-
 arch/arm/mach-digicolor/Kconfig                 |   3 +
 arch/arm/mach-imx/common.h                      |   1 +
 arch/arm/mach-imx/mach-imx6ul.c                 |   9 +
 arch/arm/mach-imx/mach-imx7d.c                  |  74 +++
 arch/arm/mach-imx/pm-imx6.c                     |  46 +-
 arch/arm/mach-imx/suspend-imx6.S                |   3 +
 arch/arm/mach-mediatek/Makefile                 |   3 +
 arch/arm/mach-mediatek/mediatek.c               |  27 +
 arch/arm/mach-mediatek/platsmp.c                | 141 +++++
 arch/arm/mach-meson/Kconfig                     |   5 +
 arch/arm/mach-meson/meson.c                     |   1 +
 arch/arm/mach-mvebu/coherency.c                 |  60 ++
 arch/arm/mach-mvebu/pmsu.c                      |  29 +-
 arch/arm/mach-orion5x/Kconfig                   |   3 +
 arch/arm/mach-orion5x/dns323-setup.c            |  53 +-
 arch/arm/mach-orion5x/tsx09-common.c            |  49 +-
 arch/arm/mach-s3c24xx/mach-h1940.c              |  10 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c             |   8 +-
 arch/arm/mach-s3c64xx/dev-backlight.c           |   4 -
 arch/arm/mach-s3c64xx/mach-crag6410.c           |   9 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                |   9 +-
 arch/arm/mach-s3c64xx/mach-smartq.c             |   9 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c           |   8 +-
 arch/arm/mach-shmobile/pm-rmobile.c             |  35 +-
 arch/arm/mach-sunxi/sunxi.c                     |   3 +-
 arch/arm/mach-tegra/board-paz00.c               |   4 +-
 arch/arm/mach-uniphier/Makefile                 |   2 +-
 arch/arm/mach-uniphier/headsmp.S                |  43 ++
 arch/arm/mach-uniphier/platsmp.c                | 185 ++++++-
 arch/arm/mm/Kconfig                             |  10 +
 arch/arm/mm/Makefile                            |   1 +
 arch/arm/mm/cache-uniphier.c                    | 555 +++++++++++++++++++
 arch/arm64/Kconfig.platforms                    |   1 +
 drivers/clk/shmobile/clk-mstp.c                 |   4 +
 drivers/clk/sunxi/clk-sunxi.c                   |   1 +
 drivers/soc/Kconfig                             |   1 +
 drivers/soc/Makefile                            |   1 +
 drivers/soc/brcmstb/Kconfig                     |   9 +
 drivers/soc/brcmstb/Makefile                    |   1 +
 drivers/soc/brcmstb/biuctrl.c                   | 116 ++++
 drivers/soc/brcmstb/common.c                    |  33 ++
 drivers/soc/mediatek/mtk-pmic-wrap.c            |  10 +-
 drivers/soc/mediatek/mtk-scpsys.c               |  83 ++-
 drivers/soc/ti/knav_qmss.h                      |   3 +-
 drivers/soc/ti/knav_qmss_acc.c                  |  10 +-
 drivers/soc/ti/knav_qmss_queue.c                |  67 ++-
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h      |  47 ++
 include/linux/platform_data/atmel.h             |   8 -
 include/linux/soc/brcmstb/brcmstb.h             |  10 +
 include/soc/brcmstb/common.h                    |  15 +
 70 files changed, 1888 insertions(+), 296 deletions(-)
 create mode 100644 Documentation/arm/keystone/knav-qmss.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mvebu-cpu-config.txt
 create mode 100644 Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
 create mode 100644 arch/arm/include/asm/hardware/cache-uniphier.h
 create mode 100644 arch/arm/mach-bcm/bcm_nsp.c
 create mode 100644 arch/arm/mach-mediatek/platsmp.c
 create mode 100644 arch/arm/mach-uniphier/headsmp.S
 create mode 100644 arch/arm/mm/cache-uniphier.c
 create mode 100644 drivers/soc/brcmstb/Kconfig
 create mode 100644 drivers/soc/brcmstb/Makefile
 create mode 100644 drivers/soc/brcmstb/biuctrl.c
 create mode 100644 drivers/soc/brcmstb/common.c
 create mode 100644 include/linux/mfd/syscon/imx7-iomuxc-gpr.h
 create mode 100644 include/linux/soc/brcmstb/brcmstb.h
 create mode 100644 include/soc/brcmstb/common.h
