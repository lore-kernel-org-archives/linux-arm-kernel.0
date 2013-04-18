From: olof@lixom.net (Olof Johansson)
Date: Wed, 17 Apr 2013 22:29:33 -0700
Subject: [GIT PULL 2/4] mvebu soc for v3.10
In-Reply-To: <20130415183605.GO28693@titan.lakedaemon.net>
References: <20130415183605.GO28693@titan.lakedaemon.net>
Message-ID: <20130418052933.GA12816@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 02:36:05PM -0400, Jason Cooper wrote:
> 
> The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:
> 
>   Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/soc_for_v3.10
> 
> for you to fetch changes up to da497f6fbaa190d34907ecc9dd85cfc62ba9f5a2:
> 
>   ARM: mvebu: Align the internal registers virtual base to support LPAE (2013-04-15 14:06:59 +0000)
> 
> ----------------------------------------------------------------
> mvebu soc changes for v3.10
> 
>  - use the mvebu-mbus driver
>  - prep for LPAE support
> 
> Depends:
>  - mvebu/cleanup (tags/cleanup_for_v3.10)
>  - mvebu/drivers (tags/drivers_for_v3.10)
> 
> ----------------------------------------------------------------
> Gregory CLEMENT (1):
>       ARM: mvebu: Limit the DMA zone when LPAE is selected
> 
> Jason Cooper (2):
>       Merge tag 'tags/cleanup_for_v3.10' into mvebu/soc
>       Merge tag 'tags/drivers_for_v3.10' into mvebu/soc
> 
> Lior Amsalem (1):
>       ARM: mvebu: Align the internal registers virtual base to support LPAE
> 
> Neil Greatorex (1):
>       bus: mvebu-mbus: Restore checking for coherency fabric hardware
> 
> Simon Guinot (1):
>       ARM: Orion: add dbg_show function to gpio-orion driver
> 
> Thomas Petazzoni (11):
>       arm: plat-orion: only build addr-map.c when needed
>       arm: plat-orion: use mv_mbus_dram_info() in PCIe code
>       arm: mach-orion5x: use mv_mbus_dram_info() in PCI code
>       bus: introduce an Marvell EBU MBus driver
>       bus: mvebu: fix mistake in PCIe window target attribute for Kirkwood
>       arm: mach-mvebu: convert to use mvebu-mbus driver
>       arm: mach-kirkwood: convert to use mvebu-mbus driver
>       arm: mach-dove: convert to use mvebu-mbus driver
>       arm: mach-orion5x: convert to use mvebu-mbus driver
>       arm: mach-mv78xx0: convert to use the mvebu-mbus driver
>       arm: plat-orion: remove addr-map code
> 
>  arch/arm/Kconfig                               |   4 +
>  arch/arm/boot/dts/armada-370-xp.dtsi           |   5 -
>  arch/arm/include/debug/mvebu.S                 |   2 +-
>  arch/arm/mach-dove/Makefile                    |   2 +-
>  arch/arm/mach-dove/addr-map.c                  | 125 ----
>  arch/arm/mach-dove/board-dt.c                  |   2 +-
>  arch/arm/mach-dove/common.c                    |  39 +-
>  arch/arm/mach-dove/common.h                    |   2 +-
>  arch/arm/mach-dove/include/mach/dove.h         |   5 +
>  arch/arm/mach-kirkwood/Makefile                |   2 +-
>  arch/arm/mach-kirkwood/addr-map.c              |  91 ---
>  arch/arm/mach-kirkwood/board-dt.c              |   2 +-
>  arch/arm/mach-kirkwood/common.c                |  38 +-
>  arch/arm/mach-kirkwood/common.h                |   2 +-
>  arch/arm/mach-kirkwood/include/mach/kirkwood.h |   7 +-
>  arch/arm/mach-kirkwood/pcie.c                  |   1 -
>  arch/arm/mach-mv78xx0/Makefile                 |   2 +-
>  arch/arm/mach-mv78xx0/addr-map.c               |  93 ---
>  arch/arm/mach-mv78xx0/common.c                 |  10 +-
>  arch/arm/mach-mv78xx0/include/mach/mv78xx0.h   |   9 +-
>  arch/arm/mach-mv78xx0/pcie.c                   |  21 +-
>  arch/arm/mach-mvebu/Kconfig                    |   2 +
>  arch/arm/mach-mvebu/Makefile                   |   2 +-
>  arch/arm/mach-mvebu/addr-map.c                 | 137 ----
>  arch/arm/mach-mvebu/armada-370-xp.c            |  18 +
>  arch/arm/mach-mvebu/armada-370-xp.h            |   8 +-
>  arch/arm/mach-mvebu/platsmp.c                  |   2 +
>  arch/arm/mach-orion5x/Makefile                 |   2 +-
>  arch/arm/mach-orion5x/addr-map.c               | 155 -----
>  arch/arm/mach-orion5x/board-dt.c               |   2 +-
>  arch/arm/mach-orion5x/common.c                 |  49 +-
>  arch/arm/mach-orion5x/common.h                 |  13 +-
>  arch/arm/mach-orion5x/d2net-setup.c            |   4 +-
>  arch/arm/mach-orion5x/db88f5281-setup.c        |  13 +-
>  arch/arm/mach-orion5x/dns323-setup.c           |   3 +-
>  arch/arm/mach-orion5x/edmini_v2-setup.c        |   4 +-
>  arch/arm/mach-orion5x/include/mach/orion5x.h   |   6 +-
>  arch/arm/mach-orion5x/kurobox_pro-setup.c      |   8 +-
>  arch/arm/mach-orion5x/ls-chl-setup.c           |   4 +-
>  arch/arm/mach-orion5x/ls_hgl-setup.c           |   4 +-
>  arch/arm/mach-orion5x/lsmini-setup.c           |   4 +-
>  arch/arm/mach-orion5x/mss2-setup.c             |   3 +-
>  arch/arm/mach-orion5x/mv2120-setup.c           |   3 +-
>  arch/arm/mach-orion5x/net2big-setup.c          |   4 +-
>  arch/arm/mach-orion5x/pci.c                    |  14 +-
>  arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |   4 +-
>  arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |   4 +-
>  arch/arm/mach-orion5x/rd88f5182-setup.c        |   7 +-
>  arch/arm/mach-orion5x/terastation_pro2-setup.c |   4 +-
>  arch/arm/mach-orion5x/ts209-setup.c            |   4 +-
>  arch/arm/mach-orion5x/ts409-setup.c            |   4 +-
>  arch/arm/mach-orion5x/wnr854t-setup.c          |   4 +-
>  arch/arm/mach-orion5x/wrt350n-v2-setup.c       |   4 +-
>  arch/arm/plat-orion/Makefile                   |   2 -
>  arch/arm/plat-orion/addr-map.c                 | 178 -----
>  arch/arm/plat-orion/gpio.c                     |  59 ++
>  arch/arm/plat-orion/pcie.c                     |  10 +-
>  drivers/bus/Kconfig                            |   7 +
>  drivers/bus/Makefile                           |   1 +
>  drivers/bus/mvebu-mbus.c                       | 870 +++++++++++++++++++++++++
>  include/linux/mbus.h                           |  27 +-
>  61 files changed, 1234 insertions(+), 883 deletions(-)
>  delete mode 100644 arch/arm/mach-dove/addr-map.c
>  delete mode 100644 arch/arm/mach-kirkwood/addr-map.c
>  delete mode 100644 arch/arm/mach-mv78xx0/addr-map.c
>  delete mode 100644 arch/arm/mach-mvebu/addr-map.c
>  delete mode 100644 arch/arm/mach-orion5x/addr-map.c
>  delete mode 100644 arch/arm/plat-orion/addr-map.c
>  create mode 100644 drivers/bus/mvebu-mbus.c

This diffstat seems to contain some of the dependencies as well, not just
the new code in this branch. I know it can be awkward to generate this
correctly, but getting it right helps us sanity-check the pull request.

Easiest is probably to do a test merge at your side (first merge the
dependencies, then the new branch), then do a diff --stat -M HEAD~. It's
similar to how I generate the pull requests when we send code to Linus.


-Olof
