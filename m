From: mayank77fromindia@gmail.com (Mayank Agarwal)
Date: Mon, 26 Nov 2012 12:19:16 +0530
Subject: linux-arm-kernel Digest, Vol 40, Issue 1034
In-Reply-To: <mailman.4850.1353733904.1038.linux-arm-kernel@lists.infradead.org>
References: <mailman.4850.1353733904.1038.linux-arm-kernel@lists.infradead.org>
Message-ID: <CAKjpqy+_xxe4k_QTuWcncMaeW9Trmddcs-jtAqFNBhHWeyGWiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,


What is the corresponding _DAC address for Aptina 8 mp MT9E013 sensor to
move the vcm motor
in integration of auto focus driver on Aptina sensor.


Regards,
Mayank

On Sat, Nov 24, 2012 at 10:41 AM, <
linux-arm-kernel-request@lists.infradead.org> wrote:

> Send linux-arm-kernel mailing list submissions to
>         linux-arm-kernel at lists.infradead.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> or, via email, send a message with subject or body 'help' to
>         linux-arm-kernel-request at lists.infradead.org
>
> You can reach the person managing the list at
>         linux-arm-kernel-owner at lists.infradead.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of linux-arm-kernel digest..."
>
>
> Today's Topics:
>
>    1. [PATCH 0/6] ARM: OMAP2+: some PM fixes and cleanup for 3.9
>       (Paul Walmsley)
>    2. [GIT PULL 1/5] ARM: orion: fixes for v3.8 (Jason Cooper)
>    3. [GIT PULL 2/5] ARM: orion: cleanup for v3.8 (Jason Cooper)
>    4. [GIT PULL 4/5] ARM: orion: dt for v3.8 (Jason Cooper)
>    5. [GIT PULL 5/5] ARM: mvebu: changes for v3.8 (Jason Cooper)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Fri, 23 Nov 2012 20:42:31 -0700
> From: Paul Walmsley <paul@pwsan.com>
> To: linux-omap at vger.kernel.org, linux-arm-kernel at lists.infradead.org
> Subject: [PATCH 0/6] ARM: OMAP2+: some PM fixes and cleanup for 3.9
> Message-ID: <20121124033809.24638.11090.stgit@dusk.lan>
> Content-Type: text/plain; charset="utf-8"
>
> Several OMAP2+ power management fixes, optimizations, and cleanup,
> intended for 3.9.  This series is a prerequisite for the functional
> powerdomain conversion series.
>
>
> - Paul
>
> ---
>
> vmlinux object size
> (delta in bytes from TEST_cleanup-prcm_c9d501e5_v3.7-rc
> (c9d501e5cb0238910337213e12a09127221c35d8)):
>    text     data      bss    total  kernel
>       0        0        0        0  am33xx_only
>     +56        0        0      +56  n800_multi_omap2xxx
>     +56        0        0      +56  n800_only_a
>       0        0        0        0  omap1_defconfig
>       0        0        0        0  omap1_defconfig_1510innovator_only
>       0        0        0        0  omap1_defconfig_5912osk_only
>    +160        0        0     +160  omap2plus_defconfig
>     +88        0        0      +88  omap2plus_defconfig_2430sdp_only
>    +108        0        0     +108  omap2plus_defconfig_cpupm
>    +160        0        0     +160  omap2plus_defconfig_no_pm
>     +32        0        0      +32  omap2plus_defconfig_omap2_4_only
>     -84        0        0      -84  omap2plus_defconfig_omap3_4_only
>    +304        0      -48     +256  rmk_omap3430_ldp_allnoconfig
>       0        0        0        0  rmk_omap3430_ldp_oldconfig
>    +304        0      -48     +256  rmk_omap4430_sdp_allnoconfig
>     -48        0        0      -48  rmk_omap4430_sdp_oldconfig
>
>
> Jean Pihet (1):
>       ARM: OMAP2+: powerdomain: fix powerdomain trace integration
>
> Paul Walmsley (5):
>       ARM: OMAP2xxx: powerdomain: core powerdomain missing logic retention
> states
>       ARM: OMAP2/3: PRM: fix bogus OMAP2xxx powerstate return values
>       ARM: OMAP3xxx: CPUIdle: simplify the PER next-state code
>       ARM: OMAP3xxx: CPUIdle: optimize __omap3_enter_idle()
>       ARM: OMAP4: MPUSS PM: remove unnecessary shim functions for
> powerdomain control
>
>
>  arch/arm/mach-omap2/cpuidle34xx.c           |   79
> ++++++++++++++----------
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c   |   43 ++-----------
>  arch/arm/mach-omap2/powerdomain.c           |    7 +-
>  arch/arm/mach-omap2/powerdomains2xxx_data.c |    1
>  arch/arm/mach-omap2/prm2xxx.c               |   88
> ++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/prm2xxx_3xxx.c          |   22 -------
>  arch/arm/mach-omap2/prm3xxx.c               |   28 ++++++++-
>  7 files changed, 166 insertions(+), 102 deletions(-)
>
>
>
>
> ------------------------------
>
> Message: 2
> Date: Sat, 24 Nov 2012 05:11:04 +0000
> From: Jason Cooper <jason@lakedaemon.net>
> To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
> Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> Subject: [GIT PULL 1/5] ARM: orion: fixes for v3.8
> Message-ID: <pull-1353733874-990435>
> Content-Type: text/plain; charset="UTF-8"
>
> The following changes since commit
> f4a75d2eb7b1e2206094b901be09adb31ba63681:
>
>   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
>
> are available in the git repository at:
>
>   git://git.infradead.org/users/jcooper/linux.git tags/orion_fixes_for_3.7
>
> for you to fetch changes up to 1dc831bf53fddcc6443f74a39e72db5bcea4f15d:
>
>   ARM: Kirkwood: Update PCI-E fixup (2012-11-21 18:30:08 +0000)
>
> ----------------------------------------------------------------
> orion fixes for v3.7
>
>  - dove irq fix
>  - kirkwood pcie fix
>
> ----------------------------------------------------------------
> Jason Gunthorpe (1):
>       ARM: Kirkwood: Update PCI-E fixup
>
> Russell King - ARM Linux (2):
>       Dove: Attempt to fix PMU/RTC interrupts
>       Dove: Fix irq_to_pmu()
>
>  arch/arm/Kconfig                     |  1 +
>  arch/arm/mach-dove/include/mach/pm.h |  2 +-
>  arch/arm/mach-dove/irq.c             | 14 +++++++++++++-
>  arch/arm/mach-kirkwood/pcie.c        | 11 ++++++++---
>  4 files changed, 23 insertions(+), 5 deletions(-)
>
>
>
> ------------------------------
>
> Message: 3
> Date: Sat, 24 Nov 2012 05:11:06 +0000
> From: Jason Cooper <jason@lakedaemon.net>
> To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
> Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> Subject: [GIT PULL 2/5] ARM: orion: cleanup for v3.8
> Message-ID:
>         <mailman.4851.1353733904.1038.linux-arm-kernel@lists.infradead.org
> >
> Content-Type: text/plain; charset="UTF-8"
>
> The following changes since commit
> f4a75d2eb7b1e2206094b901be09adb31ba63681:
>
>   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
>
> are available in the git repository at:
>
>   git://git.infradead.org/users/jcooper/linux.gittags/orion_cleanup_for_3.8
>
> for you to fetch changes up to 4a9329a04ceec56fc1ec155b6ea4d8b50f350a7b:
>
>   ARM: Kirkwood: Use hw_pci.ops instead of hw_pci.scan (2012-11-21
> 20:09:11 +0000)
>
> ----------------------------------------------------------------
> orion cleanup for v3.8
>
>  - remove unused includes in kirkwood
>  - fix sparse warnings in kirkwood
>  - checkpatch cleanup in kirkwood
>  - use common code in pcie on kirkwood
>
> ----------------------------------------------------------------
> Andrew Lunn (3):
>       ARM: Kirkwood: Remove unused includes
>       ARM: Kirkwood: Fix sparse warnings.
>       ARM: Kirkwood: checkpatch cleanups
>
> Jason Gunthorpe (1):
>       ARM: Kirkwood: Use hw_pci.ops instead of hw_pci.scan
>
> Michael Walle (1):
>       ARM: kirkwood: cleanup lsxl board includes
>
>  arch/arm/mach-kirkwood/board-dockstar.c       | 13 -----------
>  arch/arm/mach-kirkwood/board-dreamplug.c      | 15 -------------
>  arch/arm/mach-kirkwood/board-dt.c             |  4 ++--
>  arch/arm/mach-kirkwood/board-goflexnet.c      | 13 -----------
>  arch/arm/mach-kirkwood/board-ib62x0.c         |  6 ------
>  arch/arm/mach-kirkwood/board-iconnect.c       |  8 -------
>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |  2 --
>  arch/arm/mach-kirkwood/board-lsxl.c           |  8 -------
>  arch/arm/mach-kirkwood/board-ts219.c          |  3 ---
>  arch/arm/mach-kirkwood/common.c               | 11 +++++-----
>  arch/arm/mach-kirkwood/common.h               |  3 ++-
>  arch/arm/mach-kirkwood/cpuidle.c              |  2 +-
>  arch/arm/mach-kirkwood/dockstar-setup.c       |  2 +-
>  arch/arm/mach-kirkwood/irq.c                  |  1 +
>  arch/arm/mach-kirkwood/lacie_v2-common.c      |  1 +
>  arch/arm/mach-kirkwood/mpp.c                  |  4 ++--
>  arch/arm/mach-kirkwood/netspace_v2-setup.c    |  4 ++--
>  arch/arm/mach-kirkwood/openrd-setup.c         | 14 +++++-------
>  arch/arm/mach-kirkwood/pcie.c                 | 31
> +++++++--------------------
>  arch/arm/mach-kirkwood/sheevaplug-setup.c     |  2 +-
>  arch/arm/mach-kirkwood/t5325-setup.c          |  6 +++---
>  arch/arm/mach-kirkwood/ts41x-setup.c          |  3 +--
>  arch/arm/mach-kirkwood/tsx1x-common.c         |  7 +++---
>  23 files changed, 39 insertions(+), 124 deletions(-)
>
>
>
> ------------------------------
>
> Message: 4
> Date: Sat, 24 Nov 2012 05:11:11 +0000
> From: Jason Cooper <jason@lakedaemon.net>
> To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
> Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> Subject: [GIT PULL 4/5] ARM: orion: dt for v3.8
> Message-ID:
>         <mailman.4852.1353733904.1038.linux-arm-kernel@lists.infradead.org
> >
> Content-Type: text/plain; charset="UTF-8"
>
> The following changes since commit
> f4a75d2eb7b1e2206094b901be09adb31ba63681:
>
>   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
>
> are available in the git repository at:
>
>   git://git.infradead.org/users/jcooper/linux.git tags/orion_dt_for_3.8
>
> for you to fetch changes up to 2a18588c0ce336933be3c99c91e74e21db56a0fe:
>
>   ARM: Kirkwood: remove kirkwood_ehci_init() from new boards (2012-11-24
> 03:58:12 +0000)
>
> ----------------------------------------------------------------
> orion dt for v3.8
>
>  - ehci-orion dt binding
>  - gpio-poweroff
>  - use dt regulators
>  - move mpp to DT/pinctrl
>
> Depends on:
>
>  - orion/boards
>
>     - merge conflicts
>        - keep all 'select's in Kconfig
>        - remove all #includes in board-*.c
>
>  - pinctrl/devel up to:
>
>     - 06763c7 pinctrl: mvebu: move to its own directory
>
> ----------------------------------------------------------------
> Andrew Lunn (21):
>       ARM: Kirkwood: ehci-orion: Add device tree binding
>       ARM: Kirkwood: Convert all DT boards to EHCI via DT.
>       ARM: Kirkwood: Convert DNSKW to use gpio-poweroff.
>       ARM: Kirkwood: Convert IB62x0 to use gpio-poweroff.
>       ARM: Kirkwood: Enable regulator and fixed regulators.
>       ARM: Kirkwood: Convert DNSKW to use regulators
>       ARM: Kirkwood: Convert Dockstar to use regulators
>       ARM: Kirkwood: Convert GoFlexNet to use regulators
>       ARM: Kirkwood: Convert LSXL to use regulators
>       GPIO: mvebu: Allow all plat-orion platforms.
>       ARM: Kirkwood: Make use of mvebu pincltl and gpio drivers
>       ARM: Kirkwood: Add DTSI files for pinctrl
>       ARM: Kirkwood: Convert TS219 to pinctrl.
>       ARM: Kirkwood: Convert iConnect to pinctrl.
>       ARM: Kirkwood: Convert dnskw to pinctrl
>       ARM: Kirkwood: Convert dockstar to pinctrl.
>       ARM: Kirkwood: Convert dreamplug to pinctrl.
>       ARM: Kirkwood: Convert GoFlex Net to pinctrl.
>       ARM: Kirkwood: Convert ib62x0 to pinctrl.
>       ARM: Kirkwood: Convert lsxl boards to pinctrl.
>       ARM: Kirkwood: Convert IX2-200 to pinctrl.
>
> Axel Lin (1):
>       pinctrl: mvebu: Fix dove_audio1_ctrl_set function
>
> Jamie Lentin (2):
>       ARM: kirkwood: Increase NAND chip-delay for DNS-32[05]
>       power: Add simple poweroff-gpio driver
>
> Jason Cooper (5):
>       ARM: Kirkwood: add Netspace boards to defconfig
>       ARM: Kirkwood: new board USI Topkick
>       ARM: Kirkwood: update defconfig for new boards
>       Merge commit '06763c7' into orion/dt2
>       ARM: Kirkwood: remove kirkwood_ehci_init() from new boards
>
> Jason Gunthorpe (1):
>       ARM: Kirkwood: Enable the second I2C bus
>
> Linus Walleij (1):
>       pinctrl: reserve pins when states are activated
>
> Michael Walle (1):
>       ARM: kirkwood: use gpio-fan DT binding on lsxl
>
> Nobuhiro Iwamatsu (6):
>       ARM: kirkwood: Add Plat'Home OpenBlocks A6 support
>       ARM: kirkwood: Add support DT of second I2C bus
>       ARM: kirkwood: Add support second I2C bus and RTC on OpenBlocks A6
>       ARM: kirkwood: Add NAND partiton map for OpenBlocks A6
>       ARM: Kirkwood: Convert to EHCI via DT for OpenBlocks A6
>       ARM: Kirkwood: Add support LED of OpenBlocks A6
>
> Sebastian Hesselbarth (4):
>       ARM: Dove: update defconfig
>       pinctrl: mvebu: fix iomem pointer for dove pinctrl
>       ARM: Dove: Convert to DT GPIO and pinctrl
>       ARM: Dove: Add CuBox pinhog for led
>
> Simon Guinot (4):
>       leds: leds-ns2: add device tree binding
>       ARM: kirkwood: DT board setup for Network Space v2 and parents
>       ARM: kirkwood: DT board setup for Network Space Lite v2
>       ARM: kirkwood: DT board setup for Network Space Mini v2
>
> Stefan Peter (2):
>       ARM: kirkwood: Add support for the MPL CEC4
>       ARM: kirkwood: Convert mplcec4 board to pinctrl
>
> Tero Jaasko (1):
>       arm: kirkwood: add support for ZyXEL NSA310
>
> Thomas Petazzoni (7):
>       pinctrl: mvebu: allow plat-orion architectures to use pinctrl-mvebu
>       pinctrl: mvebu: remove useless include
>       pinctrl: mvebu: move to its own directory
>       arm: orion5x: mechanical defconfig update
>       arm: orion5x: basic Device Tree support
>       arm: orion5x: convert 'LaCie Ethernet Disk mini v2' to Device Tree
>       arm: orion5x: add DT related options in defconfig
>
> Valentin Longchamp (2):
>       ARM: Kirkwood: support 98DX412x kirkwoods with pinctrl
>       ARM: Kirkwood: Convert km_kirkwood to pinctrl
>
>  .../devicetree/bindings/gpio/gpio-poweroff.txt     |  22 +
>  .../devicetree/bindings/gpio/leds-ns2.txt          |  26 ++
>  .../bindings/pinctrl/marvell,kirkwood-pinctrl.txt  |  39 ++
>  .../devicetree/bindings/usb/ehci-orion.txt         |  15 +
>  Documentation/pinctrl.txt                          |   4 +-
>  arch/arm/Kconfig                                   |   4 +
>  arch/arm/boot/dts/Makefile                         |  12 +-
>  arch/arm/boot/dts/dove-cubox.dts                   |  10 +
>  arch/arm/boot/dts/dove.dtsi                        |  19 +-
>  arch/arm/boot/dts/kirkwood-6281.dtsi               |  44 ++
>  arch/arm/boot/dts/kirkwood-6282.dtsi               |  45 ++
>  arch/arm/boot/dts/kirkwood-98dx4122.dtsi           |  31 ++
>  arch/arm/boot/dts/kirkwood-dnskw.dtsi              | 140 ++++++
>  arch/arm/boot/dts/kirkwood-dockstar.dts            |  37 ++
>  arch/arm/boot/dts/kirkwood-dreamplug.dts           |  21 +
>  arch/arm/boot/dts/kirkwood-goflexnet.dts           |  73 ++++
>  arch/arm/boot/dts/kirkwood-ib62x0.dts              |  40 ++
>  arch/arm/boot/dts/kirkwood-iconnect.dts            |  51 +++
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |  89 ++++
>  arch/arm/boot/dts/kirkwood-is2.dts                 |  30 ++
>  arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |  17 +
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi               | 106 +++++
>  arch/arm/boot/dts/kirkwood-mplcec4.dts             | 178 ++++++++
>  arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  63 +++
>  arch/arm/boot/dts/kirkwood-ns2.dts                 |  30 ++
>  arch/arm/boot/dts/kirkwood-ns2lite.dts             |  30 ++
>  arch/arm/boot/dts/kirkwood-ns2max.dts              |  49 +++
>  arch/arm/boot/dts/kirkwood-ns2mini.dts             |  49 +++
>  arch/arm/boot/dts/kirkwood-nsa310.dts              | 144 ++++++
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |  98 +++++
>  arch/arm/boot/dts/kirkwood-topkick.dts             |  85 ++++
>  arch/arm/boot/dts/kirkwood-ts219-6281.dts          |  31 ++
>  arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  31 ++
>  arch/arm/boot/dts/kirkwood.dtsi                    |  17 +-
>  .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |  55 +++
>  arch/arm/boot/dts/orion5x.dtsi                     |  98 +++++
>  arch/arm/configs/dove_defconfig                    |  24 +
>  arch/arm/configs/kirkwood_defconfig                |   9 +
>  arch/arm/configs/orion5x_defconfig                 |  36 +-
>  arch/arm/mach-kirkwood/Kconfig                     |  70 +++
>  arch/arm/mach-kirkwood/Makefile                    |   9 +
>  arch/arm/mach-kirkwood/board-dnskw.c               |  54 ---
>  arch/arm/mach-kirkwood/board-dockstar.c            |  16 -
>  arch/arm/mach-kirkwood/board-dreamplug.c           |  15 -
>  arch/arm/mach-kirkwood/board-dt.c                  |  30 ++
>  arch/arm/mach-kirkwood/board-goflexnet.c           |  24 -
>  arch/arm/mach-kirkwood/board-ib62x0.c              |  35 --
>  arch/arm/mach-kirkwood/board-iconnect.c            |  18 -
>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |  26 --
>  arch/arm/mach-kirkwood/board-km_kirkwood.c         |  13 -
>  arch/arm/mach-kirkwood/board-lsxl.c                |  79 ----
>  arch/arm/mach-kirkwood/board-mplcec4.c             |  44 ++
>  arch/arm/mach-kirkwood/board-ns2.c                 |  86 ++++
>  arch/arm/mach-kirkwood/board-nsa310.c              | 101 +++++
>  arch/arm/mach-kirkwood/board-openblocks_a6.c       |  70 +++
>  arch/arm/mach-kirkwood/board-ts219.c               |  26 --
>  arch/arm/mach-kirkwood/board-usi_topkick.c         |  81 ++++
>  arch/arm/mach-kirkwood/common.c                    |   1 +
>  arch/arm/mach-kirkwood/common.h                    |  34 ++
>  arch/arm/mach-orion5x/Kconfig                      |  14 +-
>  arch/arm/mach-orion5x/Makefile                     |   4 +-
>  arch/arm/mach-orion5x/board-dt.c                   |  79 ++++
>  arch/arm/mach-orion5x/common.c                     |   4 +-
>  arch/arm/mach-orion5x/common.h                     |   9 +
>  arch/arm/mach-orion5x/edmini_v2-setup.c            |  88 +---
>  arch/arm/plat-orion/irq.c                          |   6 +-
>  drivers/gpio/Kconfig                               |   2 +-
>  drivers/leds/Kconfig                               |   4 +-
>  drivers/leds/leds-ns2.c                            |  78 +++-
>  drivers/pinctrl/Kconfig                            |  22 +-
>  drivers/pinctrl/Makefile                           |   6 +-
>  drivers/pinctrl/core.c                             |   2 +
>  drivers/pinctrl/core.h                             |   2 +
>  drivers/pinctrl/mvebu/Kconfig                      |  24 +
>  drivers/pinctrl/mvebu/Makefile                     |   5 +
>  drivers/pinctrl/{ => mvebu}/pinctrl-armada-370.c   |   0
>  drivers/pinctrl/{ => mvebu}/pinctrl-armada-xp.c    |   0
>  drivers/pinctrl/{ => mvebu}/pinctrl-dove.c         |  22 +-
>  drivers/pinctrl/mvebu/pinctrl-kirkwood.c           | 484
> +++++++++++++++++++++
>  drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.c        |   1 -
>  drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.h        |   0
>  drivers/pinctrl/pinctrl-kirkwood.c                 | 472
> --------------------
>  drivers/pinctrl/pinmux.c                           |  67 +--
>  drivers/power/Kconfig                              |   3 +
>  drivers/power/Makefile                             |   1 +
>  drivers/power/reset/Kconfig                        |  15 +
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/gpio-poweroff.c                | 129 ++++++
>  drivers/usb/host/ehci-orion.c                      |  38 +-
>  89 files changed, 3321 insertions(+), 995 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/leds-ns2.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ehci-orion.txt
>  create mode 100644 arch/arm/boot/dts/kirkwood-6281.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-6282.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-98dx4122.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-is2.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-mplcec4.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2-common.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2lite.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2max.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2mini.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-nsa310.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-openblocks_a6.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-topkick.dts
>  create mode 100644
> arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
>  create mode 100644 arch/arm/boot/dts/orion5x.dtsi
>  create mode 100644 arch/arm/mach-kirkwood/board-mplcec4.c
>  create mode 100644 arch/arm/mach-kirkwood/board-ns2.c
>  create mode 100644 arch/arm/mach-kirkwood/board-nsa310.c
>  create mode 100644 arch/arm/mach-kirkwood/board-openblocks_a6.c
>  create mode 100644 arch/arm/mach-kirkwood/board-usi_topkick.c
>  create mode 100644 arch/arm/mach-orion5x/board-dt.c
>  create mode 100644 drivers/pinctrl/mvebu/Kconfig
>  create mode 100644 drivers/pinctrl/mvebu/Makefile
>  rename drivers/pinctrl/{ => mvebu}/pinctrl-armada-370.c (100%)
>  rename drivers/pinctrl/{ => mvebu}/pinctrl-armada-xp.c (100%)
>  rename drivers/pinctrl/{ => mvebu}/pinctrl-dove.c (96%)
>  create mode 100644 drivers/pinctrl/mvebu/pinctrl-kirkwood.c
>  rename drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.c (99%)
>  rename drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.h (100%)
>  delete mode 100644 drivers/pinctrl/pinctrl-kirkwood.c
>  create mode 100644 drivers/power/reset/Kconfig
>  create mode 100644 drivers/power/reset/Makefile
>  create mode 100644 drivers/power/reset/gpio-poweroff.c
>
>
>
> ------------------------------
>
> Message: 5
> Date: Sat, 24 Nov 2012 05:11:14 +0000
> From: Jason Cooper <jason@lakedaemon.net>
> To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
> Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> Subject: [GIT PULL 5/5] ARM: mvebu: changes for v3.8
> Message-ID:
>         <mailman.4853.1353733904.1038.linux-arm-kernel@lists.infradead.org
> >
> Content-Type: text/plain; charset="UTF-8"
>
> The following changes since commit
> f4a75d2eb7b1e2206094b901be09adb31ba63681:
>
>   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
>
> are available in the git repository at:
>
>   git://git.infradead.org/users/jcooper/linux.gittags/mvebu_everything_for_3.8
>
> for you to fetch changes up to 56580bb422e5f542da19c057f348dd39634138e7:
>
>   Merge branch 'mvebu-misc-fixes' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> (2012-11-24 04:08:49 +0000)
>
> ----------------------------------------------------------------
>
> mvebu everything for v3.8
>  - due to the complex interdependencies of the received pull requests
>    I decided to keep this in one branch the way they recommended merging it
>  - this was their first attempt at doing pull requests, we'll work on it
>    with them
>
>  - added SMP support for mvebu SoCs
>  - added coherency fabric
>  - added mdio and mvneta drivers
>  - added mirabox board
>  - added openblocks ax3-4 board
>  - clock fixes and improvements
>  - converted mv_xor driver to devicetree (extensive series in itself)
>
> merge conflicts with orion/*
>  - arch/arm/mach-kirkwood/Kconfig
>     - select everything
>  - arch/arm/mach-kirkwood/board-dt.c
>     - remove AUXDATA
>     - keep all of_machine_is_compatible()
>     - use of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL)
>
> ----------------------------------------------------------------
> Andrew Lunn (3):
>       ARM: Kirkwood: switch to DT clock providers
>       dma: mv_xor: Add a device_control function
>       arm: kirkwood: Convert XOR instantiation to DT.
>
> Gregory CLEMENT (17):
>       arm: mvebu: support for the Globalscale Mirabox board
>       clk: mvebu: add armada-370-xp CPU specific clocks
>       clk: mvebu: armada 370/XP add clock gating control provider for DT
>       clk: armada-370-xp: add support for clock framework
>       clocksource: convert time-armada-370-xp to clk framework
>       arm: mvebu: increase atomic coherent pool size for armada 370/XP
>       arm: mvebu: SATA support: SoC-level DT data for Armada 370/XP
>       arm: mvebu: SATA support: mvebu_defconfig update
>       arm: mvebu: SATA support: board-level DT data for Armada 370/XP
> boards
>       arm: mvebu: Add support for coherency fabric in mach-mvebu
>       arm: mvebu: Add initial support for power managmement service unit
>       arm: mvebu: Add IPI support via doorbells
>       arm: mm: Add support for PJ4B cpu and init routines
>       arm: mvebu: Add SMP support for Armada XP
>       arm: dma mapping: Export a dma ops function arm_dma_set_mask
>       arm: plat-orion: Add coherency attribute when setup mbus target
>       arm: mvebu: Add hardware I/O Coherency support
>
> Jason Cooper (14):
>       Merge tag 'marvell-mvebu-clk-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-sata-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-neta-for-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-boards-net-for-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-net-mdio-checkpatch-fixes-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-mvneta-fix-and-clk-support-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-neta-dt-clk-updates-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-xor-cleanup-dt-binding-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-xor-board-dt-changes-3.8-v2' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-net-xor-defconfig-for-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-armadaxp-smp-for-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-hwiocc-for-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge tag 'marvell-openblocks-i2c-sata-for-3.8' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>       Merge branch 'mvebu-misc-fixes' of git://
> github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
>
> Nobuhiro Iwamatsu (3):
>       ARM: mvebu: Add support for I2C controllers in Armada 370/XP
>       ARM: mvebu: Add support for I2C on OpenBlocks AX3-4
>       ARM: mvebu: Add support for the RTC in OpenBlocks AX3-4
>
> Sebastian Hesselbarth (4):
>       clk: mvebu: add mvebu core clocks.
>       clk: mvebu: add clock gating control provider for DT
>       ARM: dove: switch to DT clock providers
>       arm: dove: Convert Dove to DT XOR DMA engine
>
> Thomas Petazzoni (74):
>       arm: mvebu: support for the PlatHome OpenBlocks AX3-4 board
>       arm: mvebu: fix compatible string in armada-370-xp.dtsi
>       arm: mvebu: don't list all boards in dt compat field for Armada
> 370/XP
>       arm: mvebu: fix typo in machine name for Armada 370/XP
>       arm: mvebu: add Ethernet controllers using mvneta driver for Armada
> 370/XP
>       arm: mvebu: enable Ethernet controllers on Armada 370/XP eval boards
>       arm: mvebu: enable Ethernet controllers on OpenBlocks AX3-4 platform
>       arm: mvebu: enable Ethernet controllers on Mirabox platform
>       net: mvmdio: new Marvell MDIO driver
>       net: mvneta: driver for Marvell Armada 370/XP network unit
>       net: mvneta: update MAINTAINERS file for the mvneta maintainers
>       dma: mv_xor: use dev_(err|info|notice) instead of dev_printk
>       dma: mv_xor: do not use pool_size from platform_data within the
> driver
>       dma: mv_xor: split initialization/cleanup of XOR channels
>       dma: mv_xor: allow channels to be registered directly from the main
> device
>       arm: plat-orion: convert the registration of the xor0 engine to the
> single driver
>       arm: plat-orion: convert the registration of the xor1 engine to the
> single driver
>       arm: plat-orion: remove unused orion_xor_init_channels()
>       dma: mv_xor: remove sub-driver 'mv_xor'
>       dma: mv_xor: remove 'shared' from mv_xor_platform_data
>       dma: mv_xor: rename mv_xor_platform_data to mv_xor_channel_data
>       dma: mv_xor: rename mv_xor_shared_platform_data to
> mv_xor_platform_data
>       dma: mv_xor: change the driver name to 'mv_xor'
>       dma: mv_xor: rename many symbols to remove the 'shared' word
>       dma: mv_xor: remove unused id field in mv_xor_device structure
>       dma: mv_xor: remove unused to_mv_xor_device() macro
>       dma: mv_xor: simplify dma_sync_single_for_cpu() calls
>       dma: mv_xor: introduce a mv_chan_to_devp() helper
>       dma: mv_xor: get rid of the pdev pointer in mv_xor_device
>       dma: mv_xor: in mv_xor_chan, rename 'common' to 'dmachan'
>       dma: mv_xor: in mv_xor_device, rename 'common' to 'dmadev'
>       dma: mv_xor: use mv_xor_chan pointers as arguments to self-test
> functions
>       dma: mv_xor: merge mv_xor_device and mv_xor_chan
>       dma: mv_xor: rename mv_xor_private to mv_xor_device
>       dma: mv_xor: remove useless backpointer from mv_xor_chan to
> mv_xor_device
>       dma: mv_xor: remove hw_id field from platform_data
>       dma: mv_xor: remove the pool_size from platform_data
>       dma: mv_xor: add missing free_irq() call
>       dma: mv_xor: add Device Tree binding
>       dma: mv_xor: add missing __devinit and __devexit qualifiers on probe
> and remove
>       arm: mvebu: add XOR engines to Armada 370 .dtsi
>       arm: mvebu: add XOR engines to Armada XP .dtsi
>       Merge tag 'marvell-mvebu-clk-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-sata-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-neta-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-boards-net-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       net: mvmdio: use <linux/delay.h> instead of <asm/delay.h>
>       net: mvmdio: adjust multiline comment to net/ style
>       net: mvneta: adjust multiline comments to net/ style
>       net: mvneta: add clk support
>       net: mvneta: fix section mismatch warning caused by mvneta_deinit()
>       arm: mvebu: add 'clocks' property to Ethernet nodes for Armada
> 370/XP SoCs
>       arm: mvebu: remove 'clock-frequency' properties from Armada 370/XP
> Ethernet nodes
>       arm: mvebu: update defconfig to include network driver
>       arm: mvebu: update defconfig to include XOR driver
>       Merge tag 'marvell-mvebu-clk-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-sata-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-neta-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-boards-net-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-net-mdio-checkpatch-fixes-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-mvneta-fix-and-clk-support-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-neta-dt-clk-updates-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-xor-cleanup-dt-binding-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-xor-board-dt-changes-3.8-v2' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       Merge tag 'marvell-net-xor-defconfig-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into test-the-merge
>       ARM: mvebu: Add SATA support for OpenBlocks AX3-4
>       ARM: mvebu: update defconfig with I2C and RTC support
>       Merge branch 'for-jason-1/cleanup' into mevbu-dt-additions
>       Merge tag 'marvell-armadaxp-smp-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public
> into mevbu-dt-additions
>       arm: mvebu: fix address decoding armada_cfg_base() function
>       dma: mv_xor: clear the window override control registers
>       dma: mv_xor: use request_irq() instead of devm_request_irq()
>       dma: mv_xor: fix error checking of irq_of_parse_and_map()
>       dma: mv_xor: fix error handling path
>
>  .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   12 +-
>  .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |   20 +
>  .../bindings/arm/armada-370-xp-timer.txt           |    1 +
>  .../devicetree/bindings/arm/coherency-fabric.txt   |   21 +
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |   47 +
>  .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   21 +
>  .../bindings/clock/mvebu-gated-clock.txt           |  119 +
>  Documentation/devicetree/bindings/dma/mv-xor.txt   |   40 +
>  .../bindings/net/marvell-armada-370-neta.txt       |   23 +
>  .../devicetree/bindings/net/marvell-orion-mdio.txt |   35 +
>  MAINTAINERS                                        |    6 +
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/boot/dts/Makefile                         |    4 +-
>  arch/arm/boot/dts/armada-370-db.dts                |   25 +-
>  arch/arm/boot/dts/armada-370-mirabox.dts           |   56 +
>  arch/arm/boot/dts/armada-370-xp.dtsi               |   63 +-
>  arch/arm/boot/dts/armada-370.dtsi                  |   51 +
>  arch/arm/boot/dts/armada-xp-db.dts                 |   44 +
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   12 +
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   19 +
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   34 +
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  125 +
>  arch/arm/boot/dts/armada-xp.dtsi                   |   84 +-
>  arch/arm/boot/dts/dove.dtsi                        |   62 +
>  arch/arm/boot/dts/kirkwood.dtsi                    |   62 +
>  arch/arm/configs/multi_v7_defconfig                |    2 +
>  arch/arm/configs/mvebu_defconfig                   |   17 +
>  arch/arm/include/asm/dma-mapping.h                 |    2 +
>  arch/arm/mach-dove/Kconfig                         |    2 +
>  arch/arm/mach-dove/common.c                        |   62 +-
>  arch/arm/mach-kirkwood/Kconfig                     |    2 +
>  arch/arm/mach-kirkwood/board-dt.c                  |   67 +-
>  arch/arm/mach-kirkwood/common.c                    |    4 +-
>  arch/arm/mach-mvebu/Kconfig                        |    7 +-
>  arch/arm/mach-mvebu/Makefile                       |    4 +-
>  arch/arm/mach-mvebu/addr-map.c                     |    5 +-
>  arch/arm/mach-mvebu/armada-370-xp.c                |   33 +-
>  arch/arm/mach-mvebu/armada-370-xp.h                |    7 +
>  arch/arm/mach-mvebu/coherency.c                    |  155 ++
>  arch/arm/mach-mvebu/coherency.h                    |   24 +
>  arch/arm/mach-mvebu/coherency_ll.S                 |   49 +
>  arch/arm/mach-mvebu/common.h                       |    5 +
>  arch/arm/mach-mvebu/headsmp.S                      |   49 +
>  arch/arm/mach-mvebu/hotplug.c                      |   30 +
>  arch/arm/mach-mvebu/irq-armada-370-xp.c            |   92 +-
>  arch/arm/mach-mvebu/platsmp.c                      |  122 +
>  arch/arm/mach-mvebu/pmsu.c                         |   75 +
>  arch/arm/mach-mvebu/pmsu.h                         |   16 +
>  arch/arm/mm/Kconfig                                |    4 +
>  arch/arm/mm/dma-mapping.c                          |    4 +-
>  arch/arm/mm/proc-v7.S                              |   67 +
>  arch/arm/plat-orion/addr-map.c                     |    4 +
>  arch/arm/plat-orion/common.c                       |  192 +-
>  arch/arm/plat-orion/include/plat/addr-map.h        |    1 +
>  arch/arm/plat-orion/include/plat/common.h          |    1 +
>  drivers/clk/Kconfig                                |    2 +
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/mvebu/Kconfig                          |    8 +
>  drivers/clk/mvebu/Makefile                         |    3 +
>  drivers/clk/mvebu/clk-core.c                       |  675 +++++
>  drivers/clk/mvebu/clk-core.h                       |   18 +
>  drivers/clk/mvebu/clk-cpu.c                        |  186 ++
>  drivers/clk/mvebu/clk-cpu.h                        |   22 +
>  drivers/clk/mvebu/clk-gating-ctrl.c                |  249 ++
>  drivers/clk/mvebu/clk-gating-ctrl.h                |   22 +
>  drivers/clk/mvebu/clk.c                            |   27 +
>  drivers/clocksource/time-armada-370-xp.c           |   11 +-
>  drivers/dma/mv_xor.c                               |  429 +--
>  drivers/dma/mv_xor.h                               |   36 +-
>  drivers/net/ethernet/marvell/Kconfig               |   24 +
>  drivers/net/ethernet/marvell/Makefile              |    2 +
>  drivers/net/ethernet/marvell/mvmdio.c              |  228 ++
>  drivers/net/ethernet/marvell/mvneta.c              | 2848
> ++++++++++++++++++++
>  include/linux/clk/mvebu.h                          |   22 +
>  include/linux/platform_data/dma-mv_xor.h           |   11 +-
>  75 files changed, 6503 insertions(+), 412 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
>  create mode 100644
> Documentation/devicetree/bindings/arm/coherency-fabric.txt
>  create mode 100644
> Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
>  create mode 100644
> Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
>  create mode 100644
> Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/mv-xor.txt
>  create mode 100644
> Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
>  create mode 100644
> Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
>  create mode 100644 arch/arm/boot/dts/armada-370-mirabox.dts
>  create mode 100644 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
>  create mode 100644 arch/arm/mach-mvebu/coherency.c
>  create mode 100644 arch/arm/mach-mvebu/coherency.h
>  create mode 100644 arch/arm/mach-mvebu/coherency_ll.S
>  create mode 100644 arch/arm/mach-mvebu/headsmp.S
>  create mode 100644 arch/arm/mach-mvebu/hotplug.c
>  create mode 100644 arch/arm/mach-mvebu/platsmp.c
>  create mode 100644 arch/arm/mach-mvebu/pmsu.c
>  create mode 100644 arch/arm/mach-mvebu/pmsu.h
>  create mode 100644 drivers/clk/mvebu/Kconfig
>  create mode 100644 drivers/clk/mvebu/Makefile
>  create mode 100644 drivers/clk/mvebu/clk-core.c
>  create mode 100644 drivers/clk/mvebu/clk-core.h
>  create mode 100644 drivers/clk/mvebu/clk-cpu.c
>  create mode 100644 drivers/clk/mvebu/clk-cpu.h
>  create mode 100644 drivers/clk/mvebu/clk-gating-ctrl.c
>  create mode 100644 drivers/clk/mvebu/clk-gating-ctrl.h
>  create mode 100644 drivers/clk/mvebu/clk.c
>  create mode 100644 drivers/net/ethernet/marvell/mvmdio.c
>  create mode 100644 drivers/net/ethernet/marvell/mvneta.c
>  create mode 100644 include/linux/clk/mvebu.h
>
>
>
> ------------------------------
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
> End of linux-arm-kernel Digest, Vol 40, Issue 1034
> **************************************************
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/3e4d5301/attachment-0001.html>
