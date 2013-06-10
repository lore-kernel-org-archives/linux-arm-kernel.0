From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 10 Jun 2013 16:30:33 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.10 (round 4)
Message-ID: <20130610203033.GP23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof

Here are two small fixes I've had in my tree for a few days.  I looked
at moving one or both of them to fixes-non-critical, but it's not
appropriate.

  5f1f3d5 arm: mvebu: armada-xp-{gp,openblocks-ax3-4}: specify PCIe range

builds on two patches already merged for v3.10 (through mvebu/fixes):

  c6c003a ARM: mvebu: Fix ranges entry on XP GP board
  8eed481 arm: mvebu: fix the 'ranges' property to handle PCIe


And:

  4089fe9 ARM: Kirkwood: handle mv88f6282 cpu in __kirkwood_variant().

Is flagged for stable, which according to Linus, is appropriate for this
stage of the -rc cycle.

If I've made an error in judgement, please let me know.

thx,

Jason.


The following changes since commit b60b61d41220c8d34e2c62a748bc78bc5d40585e:

  ARM: mvebu: Fix bug in coherency fabric low level init function (2013-05-28 14:50:08 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/fixes-3.10-4

for you to fetch changes up to 5f1f3d5088316f827591764aa6a5e7161eb514bd:

  arm: mvebu: armada-xp-{gp,openblocks-ax3-4}: specify PCIe range (2013-06-06 19:09:00 +0000)

----------------------------------------------------------------
mvebu fixes for v3.10 round 4

 - mvebu
    - fix PCIe ranges property so NOR flash is visible

 - kirkwood
    - fix identification of 88f6282 so MPPs can be set correctly

----------------------------------------------------------------
Nicolas Schichan (1):
      ARM: Kirkwood: handle mv88f6282 cpu in __kirkwood_variant().

Thomas Petazzoni (1):
      arm: mvebu: armada-xp-{gp,openblocks-ax3-4}: specify PCIe range

 arch/arm/boot/dts/armada-xp-gp.dts               | 5 +++--
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 5 +++--
 arch/arm/mach-kirkwood/mpp.c                     | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)
