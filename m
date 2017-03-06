From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 6 Mar 2017 06:29:13 +0200
Subject: [GIT PULL 1/2] Broadcom dts changes for 4.11 (part 2)
In-Reply-To: <20170202020607.31682-1-f.fainelli@gmail.com>
References: <20170202020607.31682-1-f.fainelli@gmail.com>
Message-ID: <20170306042913.phr6ooew4mkcbss6@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian, ARM SoC maintainers,

On Wed, Feb 01, 2017 at 06:06:07PM -0800, Florian Fainelli wrote:
> The following changes since commit c5a8e3add28ca4063410353acfbe6e650174e432:
> 
>   Merge tag 'bcm2835-dt-next-2017-01-17' into devicetree/next (2017-01-18 17:20:32 -0800)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux tags/arm-soc/for-4.11/devicetree-part2
> 
> for you to fetch changes up to c206e53d4c672ec83a4fc4d70eeac22d4b4ca80d:
> 
>   Merge tag 'bcm2835-dt-next-2017-01-31' into devicetree/next (2017-02-01 17:37:59 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains the second round of Device Tree updates for Broadcom
> ARM-based SoCs for 4.11, please pull the following:
> 
> - Rafal adds support for two new Linksys routers: Linksys EA9200 (BCM4709) and
>   Linksys EA6300 V1 (BCM4708)
> 
> - Dhanajay adds supports for the USB Device Tree nodes to the Northstar Plus
>   SoC
> 
> - Baruch makes several fixes to the uart0 pinctrl node names, fixes the i2c0 pins
>   and the uart0/uart1 pins as well. Finally, he adds proper indexes to the ethernet
>   aliases
> 
> - Eric merges a topic branch from the clk tree to incorporate several DSI0/1 pixel
>   clock requirements and he finally proceeds with adding proper DSI modules nodes
>   and clocks to the BCM2835 Device Tree
> 
> Please note that because of the "clk" topic branch merged by Eric, we end-up with
> pulling in v4.10-rc2 which is responsible for the funny diff here.

What happened to this pull request? v4.11-rc1 is out now.

baruch

> 
> ----------------------------------------------------------------
> Al Viro (1):
>       arm64: don't pull uaccess.h into *.S
> 
> Baruch Siach (4):
>       ARM: dts: bcm2835: fix uart0 pinctrl node names
>       ARM: dts: bcm2835: fix i2c0 pins
>       ARM: dts: bcm2835: fix uart0/uart1 pins
>       ARM: dts: bcm2835: add index to the ethernet alias
> 
> Chun-Hao Lin (1):
>       r8169: add support for RTL8168 series add-on card.
> 
> Cihangir Akturk (1):
>       Documentation/unaligned-memory-access.txt: fix incorrect comparison operator
> 
> Daniel Borkmann (1):
>       net, sched: fix soft lockup in tc_classify
> 
> Eric Anholt (5):
>       clk: bcm2835: Don't rate change PLLs on behalf of DSI PLL dividers.
>       clk: bcm2835: Register the DSI0/DSI1 pixel clocks.
>       clk: bcm2835: Add leaf clock measurement support, disabled by default
>       Merge remote-tracking branch 'clk/clk-bcm2835' into bcm2835-dt-next
>       ARM: dts: bcm2835: Add the DSI module nodes and clocks.
> 
> Eric Dumazet (1):
>       ipvlan: fix various issues in ipvlan_process_multicast()
> 
> Florian Fainelli (2):
>       net: korina: Fix NAPI versus resources freeing
>       Merge tag 'bcm2835-dt-next-2017-01-31' into devicetree/next
> 
> Haishuang Yan (1):
>       ipv4: Namespaceify tcp_tw_reuse knob
> 
> Jan Kara (6):
>       ext2: Return BH_New buffers for zeroed blocks
>       mm: Invalidate DAX radix tree entries only if appropriate
>       dax: Avoid page invalidation races and unnecessary radix tree traversals
>       dax: Finish fault completely when loading holes
>       dax: Call ->iomap_begin without entry lock during dax fault
>       ext4: Simplify DAX fault path
> 
> Jason Wang (1):
>       net: xdp: remove unused bfp_warn_invalid_xdp_buffer()
> 
> John Brooks (1):
>       docs: Fix build failure
> 
> Jon Paul Maloy (1):
>       tipc: don't send FIN message from connectionless socket
> 
> Jonathan Corbet (1):
>       Merge tag 'v4.10-rc1' into docs-next
> 
> Kweh, Hock Leong (1):
>       net: stmmac: fix incorrect bit set in gmac4 mdio addr register
> 
> Laura Abbott (1):
>       crypto: testmgr - Use heap buffer for acomp test input
> 
> Linus Torvalds (7):
>       Merge git://git.kernel.org/.../davem/net
>       Merge branch 'linus' of git://git.kernel.org/.../herbert/crypto-2.6
>       mm: optimize PageWaiters bit use for unlock_page()
>       Merge branch 'linus' of git://git.kernel.org/.../herbert/crypto-2.6
>       Merge tag 'docs-4.10-rc1-fix' of git://git.lwn.net/linux
>       Merge branch 'libnvdimm-fixes' of git://git.kernel.org/.../nvdimm/nvdimm
>       Linux 4.10-rc2
> 
> Mahesh Bandewar (1):
>       ipvlan: fix multicast processing
> 
> Olof Johansson (1):
>       mm/filemap: fix parameters to test_bit()
> 
> Rafa? Mi?ecki (2):
>       ARM: dts: BCM5301X: Add basic DT for Linksys EA9200
>       ARM: dts: BCM5301X: Add basic DT for Linksys EA6300 V1
> 
> Romain Perier (1):
>       crypto: marvell - Copy IVDIG before launching partial DMA ahash requests
> 
> Tariq Toukan (1):
>       net/mlx4_en: Fix user prio field in XDP forward
> 
> Thomas Gleixner (2):
>       smp/hotplug: Undo tglxs brainfart
>       x86/mce/AMD: Make the init code more robust
> 
> Yendapally Reddy Dhananjaya Reddy (1):
>       ARM: dts: NSP: Add USB nodes for Northstar Plus
> 
> pravin shelar (1):
>       openvswitch: upcall: Fix vlan handling.
> 
>  Documentation/DocBook/Makefile                     |   2 +-
>  .../bindings/clock/brcm,bcm2835-cprman.txt         |  15 +-
>  Documentation/unaligned-memory-access.txt          |   2 +-
>  Makefile                                           |   2 +-
>  arch/arm/boot/dts/Makefile                         |   2 +
>  arch/arm/boot/dts/bcm-nsp.dtsi                     |  56 ++++
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   8 +
>  arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi        |   2 +-
>  arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi        |   2 +-
>  arch/arm/boot/dts/bcm283x.dtsi                     |  70 ++++-
>  arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts    |  41 +++
>  arch/arm/boot/dts/bcm4709-linksys-ea9200.dts       |  42 +++
>  arch/arm/boot/dts/bcm958625k.dts                   |  16 ++
>  arch/arm64/include/asm/asm-uaccess.h               |  65 +++++
>  arch/arm64/include/asm/uaccess.h                   |  64 -----
>  arch/arm64/kernel/entry.S                          |   2 +-
>  arch/arm64/lib/clear_user.S                        |   2 +-
>  arch/arm64/lib/copy_from_user.S                    |   2 +-
>  arch/arm64/lib/copy_in_user.S                      |   2 +-
>  arch/arm64/lib/copy_to_user.S                      |   2 +-
>  arch/arm64/mm/cache.S                              |   2 +-
>  arch/arm64/xen/hypercall.S                         |   2 +-
>  arch/x86/include/asm/bitops.h                      |  13 +
>  arch/x86/kernel/cpu/mcheck/mce_amd.c               |   3 +
>  crypto/testmgr.c                                   |  30 +-
>  drivers/clk/bcm/clk-bcm2835.c                      | 303 +++++++++++++++++----
>  drivers/crypto/marvell/cesa.h                      |   3 +-
>  drivers/crypto/marvell/hash.c                      |  34 ++-
>  drivers/crypto/marvell/tdma.c                      |   9 +-
>  drivers/net/ethernet/korina.c                      |   8 +-
>  drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   3 +-
>  drivers/net/ethernet/realtek/r8169.c               |   1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   4 +-
>  drivers/net/ipvlan/ipvlan.h                        |   5 +
>  drivers/net/ipvlan/ipvlan_core.c                   |  60 ++--
>  drivers/net/ipvlan/ipvlan_main.c                   |   7 +-
>  fs/dax.c                                           | 243 +++++++++++------
>  fs/ext2/inode.c                                    |   3 +-
>  fs/ext4/file.c                                     |  48 +---
>  include/dt-bindings/clock/bcm2835.h                |   2 +
>  include/linux/dax.h                                |   3 +
>  include/linux/filter.h                             |   1 -
>  include/linux/page-flags.h                         |   2 +-
>  include/net/netns/ipv4.h                           |   1 +
>  include/net/tcp.h                                  |   1 -
>  kernel/cpu.c                                       |   9 +-
>  mm/filemap.c                                       |  36 ++-
>  mm/truncate.c                                      |  75 ++++-
>  net/core/filter.c                                  |   6 -
>  net/ipv4/sysctl_net_ipv4.c                         |  14 +-
>  net/ipv4/tcp_ipv4.c                                |   4 +-
>  net/openvswitch/datapath.c                         |   1 -
>  net/openvswitch/flow.c                             |  54 ++--
>  net/sched/cls_api.c                                |   4 +-
>  net/tipc/socket.c                                  |  24 +-
>  55 files changed, 1038 insertions(+), 379 deletions(-)
>  create mode 100644 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
>  create mode 100644 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
>  create mode 100644 arch/arm64/include/asm/asm-uaccess.h

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
