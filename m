From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Mar 2014 17:26:17 -0500
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.15 (incr. pull #3)
In-Reply-To: <20140301052536.GS1872@titan.lakedaemon.net>
References: <20140301052536.GS1872@titan.lakedaemon.net>
Message-ID: <20140303222617.GX1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Please hold off on this one.  I'm going to respin without the dove PMU
node and resend in this evening.

thx,

Jason.

On Sat, Mar 01, 2014 at 12:25:36AM -0500, Jason Cooper wrote:
> Guys,
> 
> Here's another rather large round of DT changes for mvebu.  It's all
> summed up below and has been in -next for a while now.
> 
> This is an incremental pull from tags/mvebu-dt-3.15-2 in the mvebu/dt
> branch up to tags/mvebu-dt-3.15-3.
> 
> Please pull.
> 
> thx,
> 
> Jason.
> 
> 
> The following changes since commit 7a5b293f2086cfc17519e586bd8f89be72a2fc4e:
> 
>   ARM: dove: Enable Dove watchdog in the devicetree (2014-02-17 21:44:09 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.15-3
> 
> for you to fetch changes up to 4bb86bb97b89903ce9adfa8e33dc7a46098dd13c:
> 
>   ARM: kirkwood: Add dts file describing HP T5325 thin client (2014-02-25 20:29:22 +0000)
> 
> ----------------------------------------------------------------
> mvebu dt changes for v3.15 (incremental pull #3)
> 
>  - mvebu
>     - merge armada 375, 380, 385 boards (mvebu/dt-3xx)
> 
>  - kirkwood
>     - Add many Synology NAS boards
>     - add board HP T5325
>     - add L2 cache node
>     - add system-controller node
>     - add audio node
> 
>  - dove
>     - re-add PMU interrupt controller
>     - add pinctrl and global-config register
> 
> Depends:
>  - tags/mvebu-dt-fixes-3.14 (mvebu/dt-fixes)
>     - removed dove PMU interrupt controller
> 
> Conflicts:
>  - mvebu/soc (arch/arm/boot/dts/Makefile)
>     - add/add conflict.
>     - move CONFIG_ARCH_LPC32XX to alphabetical order (after KIRKWOOD)
> 
> ----------------------------------------------------------------
> 
> Andrew Lunn (11):
>       ARM: Kirkwood: Add support for Excito Bubba B3
>       ARM: Kirkwood: Add DT description of QNAP 419
>       ARM: Kirkwood: Add DT description of rd88f6192.
>       ARM: Kirkwood: convert rd88f6281-setup.c to DT.
>       DT: Vendor prefixes: Add ricoh, qnap, sii and synology
>       DT: i2c: Trivial: Add sii,s35390a
>       ARM: kirkwood: Instantiate L2 cache from DT.
>       ARM: mvebu: Instantiate system controller in kirkwood.dtsi
>       ARM: kirkwood: Add audio node to kirkwood.dtsi
>       ARM: kirkwood: Add i2c alias so setting bus number
>       ARM: kirkwood: Add dts file describing HP T5325 thin client
> 
> Ben Peddell (1):
>       ARM: Kirkwood: Add support for many Synology NAS devices
> 
> Ezequiel Garcia (3):
>       ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
>       ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
>       ARM: dove: Enable Dove watchdog in the devicetree
> 
> Gregory CLEMENT (1):
>       ARM: mvebu: add Device Tree description of the Armada 375 SoC
> 
> Jason Cooper (5):
>       Merge tag 'tags/mvebu-dt-fixes-3.14' into mvebu/dt
>       Revert "ARM: dove: dt: revert PMU interrupt controller node"
>       Merge branch 'mvebu/dt-3xx' into mvebu/dt
>       ARM: mvebu: select dtbs from MACH_ARMADA_*
> 
> Sebastian Hesselbarth (2):
>       ARM: dove: add additional pinctrl registers
>       ARM: dove: add global-config register node
> 
> Thomas Petazzoni (12):
>       ARM: mvebu: use GPIO DT defines in Armada 370/XP boards
>       ARM: mvebu: use input DT defines in Armada 370/XP boards
>       ARM: mvebu: add audio I2S controller to Armada 370 Device Tree
>       ARM: mvebu: add I2C0 muxing option for Armada 370 SoC
>       ARM: mvebu: add audio support to Armada 370 DB
>       ARM: mvebu: enable S/PDIF audio in Armada 370 DB Device Tree
>       ARM: mvebu: add Device Tree for the Armada 375 DB board
>       ARM: mvebu: add Device Tree description of the Armada 380/385 SoCs
>       ARM: mvebu: add Device Tree for the Armada 385 DB board
>       ARM: mvebu: use C preprocessor include for Armada 375/38x DTs
>       ARM: mvebu: use GIC_{SPI,PPI} in Armada 375/38x DTs
>       ARM: mvebu: use macros for interrupt flags on Armada 375/38x
> 
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   8 +
>  arch/arm/boot/dts/Makefile                         |  36 +-
>  arch/arm/boot/dts/armada-370-db.dts                |  56 ++
>  arch/arm/boot/dts/armada-370-mirabox.dts           |   7 +-
>  arch/arm/boot/dts/armada-370-rd.dts                |   6 +-
>  arch/arm/boot/dts/armada-370-xp.dtsi               |   4 +
>  arch/arm/boot/dts/armada-370.dtsi                  |  33 +
>  arch/arm/boot/dts/armada-375-db.dts                | 130 +++
>  arch/arm/boot/dts/armada-375.dtsi                  | 464 +++++++++++
>  arch/arm/boot/dts/armada-380.dtsi                  | 117 +++
>  arch/arm/boot/dts/armada-385-db.dts                | 101 +++
>  arch/arm/boot/dts/armada-385.dtsi                  | 149 ++++
>  arch/arm/boot/dts/armada-38x.dtsi                  | 351 +++++++++
>  arch/arm/boot/dts/armada-xp-axpwifiap.dts          |   6 +-
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  12 +-
>  arch/arm/boot/dts/armada-xp.dtsi                   |   6 +
>  arch/arm/boot/dts/dove.dtsi                        |  29 +-
>  arch/arm/boot/dts/kirkwood-b3.dts                  | 204 +++++
>  arch/arm/boot/dts/kirkwood-ds109.dts               |  41 +
>  arch/arm/boot/dts/kirkwood-ds110jv10.dts           |  41 +
>  arch/arm/boot/dts/kirkwood-ds111.dts               |  44 ++
>  arch/arm/boot/dts/kirkwood-ds112.dts               |  48 ++
>  arch/arm/boot/dts/kirkwood-ds209.dts               |  44 ++
>  arch/arm/boot/dts/kirkwood-ds210.dts               |  46 ++
>  arch/arm/boot/dts/kirkwood-ds212.dts               |  47 ++
>  arch/arm/boot/dts/kirkwood-ds212j.dts              |  41 +
>  arch/arm/boot/dts/kirkwood-ds409.dts               |  48 ++
>  arch/arm/boot/dts/kirkwood-ds409slim.dts           |  40 +
>  arch/arm/boot/dts/kirkwood-ds411.dts               |  52 ++
>  arch/arm/boot/dts/kirkwood-ds411j.dts              |  48 ++
>  arch/arm/boot/dts/kirkwood-ds411slim.dts           |  48 ++
>  arch/arm/boot/dts/kirkwood-rd88f6192.dts           | 112 +++
>  arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts        |  26 +
>  arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts        |  31 +
>  arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          | 152 ++++
>  arch/arm/boot/dts/kirkwood-rs212.dts               |  48 ++
>  arch/arm/boot/dts/kirkwood-rs409.dts               |  44 ++
>  arch/arm/boot/dts/kirkwood-rs411.dts               |  44 ++
>  arch/arm/boot/dts/kirkwood-synology.dtsi           | 871 +++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-t5325.dts               | 208 +++++
>  arch/arm/boot/dts/kirkwood-ts419-6281.dts          |  20 +
>  arch/arm/boot/dts/kirkwood-ts419-6282.dts          |  32 +
>  arch/arm/boot/dts/kirkwood-ts419.dtsi              |  75 ++
>  arch/arm/boot/dts/kirkwood.dtsi                    |  24 +-
>  45 files changed, 3976 insertions(+), 19 deletions(-)
>  create mode 100644 arch/arm/boot/dts/armada-375-db.dts
>  create mode 100644 arch/arm/boot/dts/armada-375.dtsi
>  create mode 100644 arch/arm/boot/dts/armada-380.dtsi
>  create mode 100644 arch/arm/boot/dts/armada-385-db.dts
>  create mode 100644 arch/arm/boot/dts/armada-385.dtsi
>  create mode 100644 arch/arm/boot/dts/armada-38x.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-b3.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds109.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds110jv10.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds111.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds112.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds209.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds210.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds212.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds212j.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds409.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds409slim.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds411.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds411j.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds411slim.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6192.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-rs212.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rs409.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rs411.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-synology.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-t5325.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6281.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6282.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ts419.dtsi
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
