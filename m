From: horms@verge.net.au (Simon Horman)
Date: Mon, 21 Jan 2013 09:32:37 +0900
Subject: [GIT PULL] Renesas ARM-based SoC v3.9
In-Reply-To: <20130116063750.GA11765@verge.net.au>
References: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
 <20130116063750.GA11765@verge.net.au>
Message-ID: <20130121003237.GA2639@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 03:37:53PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> I have some complex dependencies for mach-shmobile for v3.9
> and as such I am sending this email outline the dependencies
> of branches on each other. I have also included the multiple
> pull requests below though I am happy to post them
> individually including the patches they comprise if you
> have no objections to the way the branch dependencies are arranged.
> 
> I would also be happy to supply a single branch with all changes
> with or without merge commits.
> 
> All branches are present in the renesas tree
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

Ping.

> 1. Branch: sh-soc
>    Description: Pre-requisites for pfc changes for SH SoCs
>    Based on: v3.8-rc1
> 
> 2. Branch: clocksource
>    Description: Pre-requisite clocksource change for soc branch
>    Based on: v3.8-rc1
> 
> 3. Branch: pfc
>    Description: PFC Updates
>    Based on: sh-soc
> 
> 4. Branch: sh-soc2
>    Description: Further PFC changes for SH SoCs
>    Based on: pfc
> 
> 5. Branch: soc
>    Description: shmobile (ARM) SoCs updates, including PFC changes.
>    Based on: a merge of clocksource and pfc
> 
> 6. Branch: boards
>    Description: Board changes, including PFC changes.
>    Based on: A merge of timer/cleanup (present in the arm-soc tree) and soc
> 
> 7. Branch: pfc2
>    Description: Further PFC changes which depend on SoC changes
>    Based on: A merge of sh-soc2 and soc
> 
> 8. Branch: sh-soc3
>    Description: Further PFC changes for SH SoCs
>    Based on: pfc2
> 
> 9. Branch: soc2
>    Description: Further PFC changes for shmobile (ARM) SoCs
>    Based on: A merge of timer/cleanup (present in the arm-soc tree) and pfc2
> 
> 10. Branch: pfc3
>     Description: Description: Further PFC changes which depend on SoC changes
>     Based on: A merge of sh-soc3 and soc2
> 
> And now to the pull-requests:
> 
> ================================================================
> 1.
> 
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git sh-soc
> 
> for you to fetch changes up to 2cbf52318a995c09de88dc7c3067d387d7d9ffe8:
> 
>   sh: shx3: Fix last GPIO index (2013-01-07 14:44:46 +0900)
> 
> ----------------------------------------------------------------
> Laurent Pinchart (7):
>       sh: sh7264: Rename CRX0CRX1 mark to match GPIO names
>       sh: sh7269: Rename CRX0CRX1(CRX2) marks to match GPIO names
>       sh: sh7723: Rename GPIO_FN_SIUOSPD to GPIO_FN_SIUAOSPD
>       sh: sh7757: Fix GPIO_FN_ET0_MDIO and GPIO_FN_ET1_MDIO GPIO entries
>       sh: sh7786: Fix port E, G and J GPIOs
>       sh: sh7786: Fix last GPIO index
>       sh: shx3: Fix last GPIO index
> 
>  arch/sh/include/cpu-sh4/cpu/sh7723.h    |    2 +-
>  arch/sh/include/cpu-sh4/cpu/sh7786.h    |    8 +++-----
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c |    6 +++---
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c |   12 ++++++------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c |    2 +-
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c |    4 ++--
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |    6 +++---
>  arch/sh/kernel/cpu/sh4a/pinmux-shx3.c   |    2 +-
>  8 files changed, 20 insertions(+), 22 deletions(-)
> 
> ================================================================
> 2.
> 
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git clocksource
> 
> for you to fetch changes up to 892a45dbe32eb565c07d08085e694985e6fbaf26:
> 
>   ARM: clocksource: Initialise early (2013-01-16 14:55:11 +0900)
> 
> ----------------------------------------------------------------
> Simon Horman (1):
>       ARM: clocksource: Initialise early
> 
>  drivers/Makefile |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> ================================================================
> 3.
> 
> The following changes since commit 2cbf52318a995c09de88dc7c3067d387d7d9ffe8:
> 
>   sh: shx3: Fix last GPIO index (2013-01-07 14:44:46 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git pfc
> 
> for you to fetch changes up to 3951da29e5981e3441fdd79a9363fd1af739374b:
> 
>   sh-pfc: Support passing resources through platform device (2013-01-07 14:47:55 +0900)
> 
> ----------------------------------------------------------------
> Laurent Pinchart (14):
>       sh-pfc: Remove all use of __devinit/__devexit
>       sh-pfc: Split platform data from the sh_pfc structure
>       sh-pfc: Move private definitions and declarations to private header
>       sh-pfc: Merge PFC core and pinctrl
>       sh-pfc: Merge PFC core and gpio
>       sh-pfc: Move platform device and driver to the core
>       sh-pfc: Use devm_kzalloc()
>       sh-pfc: Use devm_ioremap_nocache()
>       sh-pfc: Let the compiler decide whether to inline functions
>       sh-pfc: Remove check for impossible error condition
>       sh-pfc: Sort headers alphabetically
>       sh-pfc: Use sh_pfc_ namespace prefix through the whole driver
>       sh-pfc: Split platform device and platform driver registration
>       sh-pfc: Support passing resources through platform device
> 
>  drivers/sh/pfc/Kconfig   |   12 +-
>  drivers/sh/pfc/Makefile  |    8 +-
>  drivers/sh/pfc/core.c    |  327 +++++++++++++++++++++++++---------------------
>  drivers/sh/pfc/core.h    |   54 ++++++++
>  drivers/sh/pfc/gpio.c    |  113 ++++------------
>  drivers/sh/pfc/pinctrl.c |  171 ++++++++----------------
>  include/linux/sh_pfc.h   |   35 +----
>  7 files changed, 326 insertions(+), 394 deletions(-)
>  create mode 100644 drivers/sh/pfc/core.h
> 
> ================================================================
> 4.
> 
> The following changes since commit 3951da29e5981e3441fdd79a9363fd1af739374b:
> 
>   sh-pfc: Support passing resources through platform device (2013-01-07 14:47:55 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git sh-soc2
> 
> for you to fetch changes up to 85a76791fa8c2f1e5467557c52fcbfaff90db586:
> 
>   sh: shx3: Register PFC platform device (2013-01-07 14:50:54 +0900)
> 
> ----------------------------------------------------------------
> Laurent Pinchart (13):
>       sh: Add PFC platform device registration helper function
>       sh: sh7203: Register PFC platform device
>       sh: sh7264: Register PFC platform device
>       sh: sh7269: Register PFC platform device
>       sh: sh7720: Register PFC platform device
>       sh: sh7722: Register PFC platform device
>       sh: sh7723: Register PFC platform device
>       sh: sh7724: Register PFC platform device
>       sh: sh7734: Register PFC platform device
>       sh: sh7757: Register PFC platform device
>       sh: sh7785: Register PFC platform device
>       sh: sh7786: Register PFC platform device
>       sh: shx3: Register PFC platform device
> 
>  arch/sh/Kconfig                         |   12 +++++++++
>  arch/sh/include/cpu-common/cpu/pfc.h    |   30 +++++++++++++++++++++
>  arch/sh/kernel/cpu/Makefile             |    2 +-
>  arch/sh/kernel/cpu/pfc.c                |   44 +++++++++++++++++++++++++++++++
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c |    3 ++-
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c |    3 ++-
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c |    3 ++-
>  arch/sh/kernel/cpu/sh3/pinmux-sh7720.c  |    3 ++-
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c |    8 +++---
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |    3 ++-
>  arch/sh/kernel/cpu/sh4a/pinmux-shx3.c   |    3 ++-
>  16 files changed, 113 insertions(+), 16 deletions(-)
>  create mode 100644 arch/sh/include/cpu-common/cpu/pfc.h
>  create mode 100644 arch/sh/kernel/cpu/pfc.c
> 
> ================================================================
> 5.
> 
> The following changes since commit 3951da29e5981e3441fdd79a9363fd1af739374b:
> 
>   sh-pfc: Support passing resources through platform device (2013-01-07 14:47:55 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc
> 
> for you to fetch changes up to 54689817eb3476be410b42a9ce2bff82037b4334:
> 
>   ARM: SH-Mobile: sh73a0: Add CPU Hotplug (2013-01-16 14:16:25 +0900)
> 
> ----------------------------------------------------------------
> Bastian Hecht (4):
>       ARM: shmobile: sh73a0: Add CPU sleep suspend
>       ARM: shmobile: r8a7740: Add CPU sleep suspend
>       ARM: SH-Mobile: sh73a0: Secondary CPUs handle own SCU flags
>       ARM: SH-Mobile: sh73a0: Add CPU Hotplug
> 
> Guennadi Liakhovetski (3):
>       ARM: sh7372: add clock lookup entries for DT-based devices
>       ARM: sh7372: fix cache clean / invalidate order
>       ARM: shmobile: add function declarations for sh7372 DT helper functions
> 
> Kuninori Morimoto (2):
>       ARM: shmobile: r8a7740: add TMU timer support
>       ARM: shmobile: sh73a0: fixup div4_clks bitmap
> 
> Laurent Pinchart (8):
>       ARM: shmobile: Select PINCTRL
>       ARM: shmobile: r8a7740: Register PFC platform device
>       ARM: shmobile: r8a7779: Register PFC platform device
>       ARM: shmobile: sh7372: Register PFC platform device
>       ARM: shmobile: sh73a0: Register PFC platform device
>       ARM: shmobile: r8a7740: Add pin control resources
>       ARM: shmobile: sh7372: Add pin control resources
>       ARM: shmobile: sh73a0: Add pin control resources
> 
> Magnus Damm (1):
>       ARM: mach-shmobile: sh73a0 external IRQ wake update
> 
> Simon Horman (4):
>       ARM: shmobile: Remove duplicate inclusion of dma-mapping.h in setup-r8a7740.c
>       ARM: mach-shmobile: sh73a0: Allow initialisation of GIC by DT
>       ARM: mach-shmobile: sh73a0: Minimal setup using DT
>       ARM: mach-shmobile: sh73a0: Initialise MMCIF using DT
> 
>  arch/arm/Kconfig                               |    1 +
>  arch/arm/boot/dts/sh73a0-reference.dtsi        |   24 ++++++
>  arch/arm/boot/dts/sh73a0.dtsi                  |   93 +++++++++++++++++++++++
>  arch/arm/mach-shmobile/Makefile                |    3 +-
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +
>  arch/arm/mach-shmobile/board-kzm9g.c           |    2 +
>  arch/arm/mach-shmobile/clock-r8a7740.c         |    6 +-
>  arch/arm/mach-shmobile/clock-sh7372.c          |    9 +++
>  arch/arm/mach-shmobile/clock-sh73a0.c          |   35 ++++++---
>  arch/arm/mach-shmobile/headsmp-sh73a0.S        |   50 +++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h   |    8 ++
>  arch/arm/mach-shmobile/intc-sh73a0.c           |   21 ++++--
>  arch/arm/mach-shmobile/pfc-r8a7740.c           |   28 ++++++-
>  arch/arm/mach-shmobile/pfc-r8a7779.c           |   16 +++-
>  arch/arm/mach-shmobile/pfc-sh7372.c            |   28 ++++++-
>  arch/arm/mach-shmobile/pfc-sh73a0.c            |   28 ++++++-
>  arch/arm/mach-shmobile/pm-r8a7740.c            |   22 ++++++
>  arch/arm/mach-shmobile/pm-sh73a0.c             |   32 ++++++++
>  arch/arm/mach-shmobile/setup-r8a7740.c         |   95 +++++++++++++++++++++++-
>  arch/arm/mach-shmobile/setup-sh73a0.c          |   64 +++++++++++++++-
>  arch/arm/mach-shmobile/sleep-sh7372.S          |   12 +--
>  arch/arm/mach-shmobile/smp-sh73a0.c            |   66 ++++++++--------
>  22 files changed, 580 insertions(+), 65 deletions(-)
>  create mode 100644 arch/arm/boot/dts/sh73a0-reference.dtsi
>  create mode 100644 arch/arm/boot/dts/sh73a0.dtsi
>  create mode 100644 arch/arm/mach-shmobile/headsmp-sh73a0.S
>  create mode 100644 arch/arm/mach-shmobile/pm-sh73a0.c
> 
> ================================================================
> 6.
> 
> The following changes since commit b7e481b082bf48707020bef270aa726b96d7b4be:
> 
>   Merge branches 'soc' and 'clocksource', remote-tracking branch 'arm-soc/timer/cleanup' into boards (2013-01-16 15:27:26 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards
> 
> for you to fetch changes up to 2b88c35a7ddd49301eb73a4660e012bba61a3504:
> 
>   ARM: mach-shmobile: kzm9g: Reference DT implementation (2013-01-16 15:27:41 +0900)
> 
> ----------------------------------------------------------------
> Guennadi Liakhovetski (1):
>       ARM: mackerel: include the correct .dtsi file
> 
> Kuninori Morimoto (3):
>       ARM: shmobile: fix sample amixer settings for mackerel
>       ARM: shmobile: add sample amixer settings for ap4evb
>       ARM: shmobile: add sample amixer settings for armadillo800eva
> 
> Laurent Pinchart (2):
>       ARM: shmobile: kzm9g: Use of_machine_is_compatible()
>       ARM: shmobile: Include sh73a0 DTSI in kzm9g
> 
> Nobuhiro Iwamatsu (1):
>       ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva
> 
> Simon Horman (1):
>       ARM: mach-shmobile: kzm9g: Reference DT implementation
> 
>  arch/arm/boot/dts/Makefile                     |    1 +
>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts  |    2 +-
>  arch/arm/boot/dts/sh7372-mackerel.dts          |    2 +-
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   37 +++++++++
>  arch/arm/boot/dts/sh73a0-kzm9g.dts             |    2 +-
>  arch/arm/mach-shmobile/Kconfig                 |   10 +++
>  arch/arm/mach-shmobile/Makefile                |    1 +
>  arch/arm/mach-shmobile/board-ap4evb.c          |    4 +
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    8 ++
>  arch/arm/mach-shmobile/board-kzm9g-reference.c |   99 ++++++++++++++++++++++++
>  arch/arm/mach-shmobile/board-kzm9g.c           |    2 +-
>  arch/arm/mach-shmobile/board-mackerel.c        |    4 +-
>  12 files changed, 165 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>  create mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c
> 
> ================================================================
> 7.
> 
> The following changes since commit e35442480c27092fd7c5ecd987a225bab448d031:
> 
>   Merge branches 'soc' and 'sh-soc2' into pfc2 (2013-01-16 14:33:26 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git pfc2
> 
> for you to fetch changes up to 5800cb822fbda9378fd8eb8cfd19369b5833bd34:
> 
>   sh-pfc: Add shx3 pinmux support (2013-01-16 14:34:00 +0900)
> 
> ----------------------------------------------------------------
> Laurent Pinchart (20):
>       sh-pfc: Remove platform device registration
>       sh-pfc: Remove unused resource and num_resources platform data fields
>       sh-pfc: Move driver from drivers/sh/ to drivers/pinctrl/
>       sh-pfc: Support pinmux info in driver data instead of platform data
>       sh-pfc: Add r8a7740 pinmux support
>       sh-pfc: Add r8a7779 pinmux support
>       sh-pfc: Add sh7372 pinmux support
>       sh-pfc: Add sh73a0 pinmux support
>       sh-pfc: Add sh7203 pinmux support
>       sh-pfc: Add sh7264 pinmux support
>       sh-pfc: Add sh7269 pinmux support
>       sh-pfc: Add sh7720 pinmux support
>       sh-pfc: Add sh7722 pinmux support
>       sh-pfc: Add sh7723 pinmux support
>       sh-pfc: Add sh7724 pinmux support
>       sh-pfc: Add sh7734 pinmux support
>       sh-pfc: Add sh7757 pinmux support
>       sh-pfc: Add sh7785 pinmux support
>       sh-pfc: Add sh7786 pinmux support
>       sh-pfc: Add shx3 pinmux support
> 
>  drivers/pinctrl/Kconfig                      |    2 +-
>  drivers/pinctrl/Makefile                     |    2 +
>  drivers/pinctrl/sh-pfc/Kconfig               |  116 ++
>  drivers/pinctrl/sh-pfc/Makefile              |   21 +
>  drivers/{sh/pfc => pinctrl/sh-pfc}/core.c    |  129 +-
>  drivers/{sh/pfc => pinctrl/sh-pfc}/core.h    |   19 +-
>  drivers/{sh/pfc => pinctrl/sh-pfc}/gpio.c    |   18 +-
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c         | 2611 ++++++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c         | 2623 ++++++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7203.c          | 1591 +++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7264.c          | 2130 +++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7269.c          | 2833 ++++++++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7372.c          | 1657 +++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c          | 2797 +++++++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7720.c          | 1235 +++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7722.c          | 1778 ++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7723.c          | 1902 +++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7724.c          | 2224 ++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7734.c          | 2474 ++++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7757.c          | 2281 +++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7785.c          | 1303 ++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-sh7786.c          |  836 ++++++++
>  drivers/pinctrl/sh-pfc/pfc-shx3.c            |  581 ++++++
>  drivers/{sh/pfc => pinctrl/sh-pfc}/pinctrl.c |   28 +-
>  drivers/sh/Kconfig                           |    1 -
>  drivers/sh/Makefile                          |    1 -
>  drivers/sh/pfc/Kconfig                       |   18 -
>  drivers/sh/pfc/Makefile                      |    5 -
>  include/linux/sh_pfc.h                       |   17 +-
>  29 files changed, 31118 insertions(+), 115 deletions(-)
>  create mode 100644 drivers/pinctrl/sh-pfc/Kconfig
>  create mode 100644 drivers/pinctrl/sh-pfc/Makefile
>  rename drivers/{sh/pfc => pinctrl/sh-pfc}/core.c (79%)
>  rename drivers/{sh/pfc => pinctrl/sh-pfc}/core.h (63%)
>  rename drivers/{sh/pfc => pinctrl/sh-pfc}/gpio.c (89%)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7740.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7779.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7203.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7264.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7269.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7372.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh73a0.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7720.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7722.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7723.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7724.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7734.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7757.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7785.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7786.c
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-shx3.c
>  rename drivers/{sh/pfc => pinctrl/sh-pfc}/pinctrl.c (93%)
>  delete mode 100644 drivers/sh/pfc/Kconfig
>  delete mode 100644 drivers/sh/pfc/Makefile
> 
> ================================================================
> 8.
> 
> The following changes since commit 5800cb822fbda9378fd8eb8cfd19369b5833bd34:
> 
>   sh-pfc: Add shx3 pinmux support (2013-01-16 14:34:00 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git sh-soc3
> 
> for you to fetch changes up to 09b276b8c3a590839d3dd199c7116ff5f8fe36e6:
> 
>   sh: shx3: pinmux: Use driver-provided pinmux info (2013-01-16 14:42:19 +0900)
> 
> ----------------------------------------------------------------
> Laurent Pinchart (12):
>       sh: sh7203: pinmux: Use driver-provided pinmux info
>       sh: sh7264: pinmux: Use driver-provided pinmux info
>       sh: sh7269: pinmux: Use driver-provided pinmux info
>       sh: sh7720: pinmux: Use driver-provided pinmux info
>       sh: sh7722: pinmux: Use driver-provided pinmux info
>       sh: sh7723: pinmux: Use driver-provided pinmux info
>       sh: sh7724: pinmux: Use driver-provided pinmux info
>       sh: sh7734: pinmux: Use driver-provided pinmux info
>       sh: sh7757: pinmux: Use driver-provided pinmux info
>       sh: sh7785: pinmux: Use driver-provided pinmux info
>       sh: sh7786: pinmux: Use driver-provided pinmux info
>       sh: shx3: pinmux: Use driver-provided pinmux info
> 
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c | 1581 +----------------
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c | 2120 +----------------------
>  arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c | 2822 +------------------------------
>  arch/sh/kernel/cpu/sh3/pinmux-sh7720.c  | 1225 +-------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c | 1777 +------------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c | 1892 +--------------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c | 2209 +-----------------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c | 2468 +--------------------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c | 2266 +------------------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c | 1293 +-------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |  821 +--------
>  arch/sh/kernel/cpu/sh4a/pinmux-shx3.c   |  572 +------
>  12 files changed, 14 insertions(+), 21032 deletions(-)
> 
> ================================================================
> 9.
> 
> The following changes since commit c1857e7b2da094b23db24e0829565264d3ba888d:
> 
>   Merge branch 'pfc2', remote-tracking branch 'arm-soc/timer/cleanup' into soc2 (2013-01-16 14:35:00 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc2
> 
> for you to fetch changes up to ed68adfe853db33aad6a294702396736ba220af6:
> 
>   ARM: shmobile: sh73a0: Use driver-provided pinmux info (2013-01-16 14:38:47 +0900)
> 
> ----------------------------------------------------------------
> Laurent Pinchart (4):
>       ARM: shmobile: r8a7740: Use driver-provided pinmux info
>       ARM: shmobile: r8a7779: Use driver-provided pinmux info
>       ARM: shmobile: sh7372: Use driver-provided pinmux info
>       ARM: shmobile: sh73a0: Use driver-provided pinmux info
> 
>  arch/arm/mach-shmobile/Makefile        |    8 -
>  arch/arm/mach-shmobile/pfc-r8a7740.c   | 2643 -----------------------------
>  arch/arm/mach-shmobile/pfc-r8a7779.c   | 2653 ------------------------------
>  arch/arm/mach-shmobile/pfc-sh7372.c    | 1689 -------------------
>  arch/arm/mach-shmobile/pfc-sh73a0.c    | 2829 --------------------------------
>  arch/arm/mach-shmobile/setup-r8a7740.c |   26 +
>  arch/arm/mach-shmobile/setup-r8a7779.c |   25 +
>  arch/arm/mach-shmobile/setup-sh7372.c  |   26 +
>  arch/arm/mach-shmobile/setup-sh73a0.c  |   25 +
>  9 files changed, 102 insertions(+), 9822 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/pfc-r8a7740.c
>  delete mode 100644 arch/arm/mach-shmobile/pfc-r8a7779.c
>  delete mode 100644 arch/arm/mach-shmobile/pfc-sh7372.c
>  delete mode 100644 arch/arm/mach-shmobile/pfc-sh73a0.c
> 
> ================================================================
> 10.
> 
> The following changes since commit 29ef16511e7645caa979b4db432bf30359fd3795:
> 
>   Merge branches 'soc2' and 'sh-soc3' into pfc3 (2013-01-16 14:42:55 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git pfc3
> 
> for you to fetch changes up to 52c59e03952165b9d462f7001095eb5b8808aed6:
> 
>   sh-pfc: Move sh_pfc.h from include/linux/ to driver directory (2013-01-16 14:43:06 +0900)
> 
> ----------------------------------------------------------------
> Laurent Pinchart (3):
>       sh: Remove unused sh_pfc_register_info() function
>       sh-pfc: Remove pinmux_info definition
>       sh-pfc: Move sh_pfc.h from include/linux/ to driver directory
> 
>  arch/sh/include/asm/gpio.h                         |    2 +-
>  arch/sh/include/cpu-common/cpu/pfc.h               |    4 ----
>  arch/sh/kernel/cpu/pfc.c                           |   13 +------------
>  drivers/pinctrl/sh-pfc/core.c                      |    1 -
>  drivers/pinctrl/sh-pfc/core.h                      |    3 ++-
>  drivers/pinctrl/sh-pfc/gpio.c                      |    1 -
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c               |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7203.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7264.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7269.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7372.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7720.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7722.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7723.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7724.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7734.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7757.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7785.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-sh7786.c                |    3 ++-
>  drivers/pinctrl/sh-pfc/pfc-shx3.c                  |    3 ++-
>  drivers/pinctrl/sh-pfc/pinctrl.c                   |    1 -
>  {include/linux => drivers/pinctrl/sh-pfc}/sh_pfc.h |    3 ---
>  24 files changed, 36 insertions(+), 40 deletions(-)
>  rename {include/linux => drivers/pinctrl/sh-pfc}/sh_pfc.h (98%)
> 
> ================================================================
> 
