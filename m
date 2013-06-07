From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Jun 2013 17:21:58 +0900
Subject: [GIT PULL 00/11] Renesas ARM-based SoC board updates for v3.11
Message-ID: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

Please note that this pull request is based on a merge of the
renesas-pinmux-for-v3.11 and renesas-soc-for-v3.11 tags
in the renesas tree in order to provide dependencies.

I have sent pull requests for each of those tags as:
[GIT PULL 000/130] Renesas ARM based SoC pinmux and GPIO update for
[GIT PULL v2 00/27] Renesas ARM-based SoC updates for v3.11


The following changes since commit a961ee1c95cb7309f619e9e68fe8c4fb73bedf6f:

  Merge branches 'pinmux' and 'soc' into boards-base (2013-06-07 14:26:22 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.11

for you to fetch changes up to f3031ff3f2e14f0ced4d45150316df2607b70a27:

  ARM: shmobile: marzen: keep local function as static (2013-06-07 14:26:35 +0900)

----------------------------------------------------------------
Renesas ARM-based SoC board updates for v3.11

Highlights:
bockw: add SDHI0 support
bockw: add dummy regulators for SMSC
bockw: Document CN9 SCIF/RCAN dipswitch selection
lager: support GPIO switches and LEDs
kzm9g: add AS3711 PMIC platform data
marzen: Use INTC External IRQ pin driver for SMSC
ape6evm: Update MP clock parent become EXTAL2 in line with changes
         to r8a73a4 SoC code

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: shmobile: kzm9g: add AS3711 PMIC platform data

Kuninori Morimoto (6):
      ARM: shmobile: ape6evm: MP clock parent become EXTAL2
      ARM: shmobile: bockw: define FPGA address and rename iomem variable
      ARM: shmobile: bockw: add CN9 SCIF/RCAN selection dipswitch explanation
      ARM: shmobile: bockw: add dummy regulators for SMSC
      ARM: shmobile: bockw: add SDHI0 support
      ARM: shmobile: marzen: keep local function as static

Simon Horman (4):
      ARM: shmobile: kzm9d: resigser smsc911x platform device with id -1
      ARM: shmobile: lager: Add GPIO LEDs
      ARM: shmobile: lager: support GPIO switches
      ARM: shmobile: marzen: Use INTC External IRQ pin driver for SMSC

 arch/arm/mach-shmobile/board-ape6evm.c |  15 +++
 arch/arm/mach-shmobile/board-bockw.c   |  61 ++++++++++-
 arch/arm/mach-shmobile/board-kzm9d.c   |   2 +-
 arch/arm/mach-shmobile/board-kzm9g.c   | 193 ++++++++++++++++++++++++---------
 arch/arm/mach-shmobile/board-lager.c   |  49 +++++++++
 arch/arm/mach-shmobile/board-marzen.c  |   5 +-
 6 files changed, 263 insertions(+), 62 deletions(-)

-- 
1.8.2.1
