From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 2 Oct 2013 12:20:21 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.12 (round 2)
Message-ID: <20131002162021.GM31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Folks,

Here's the second round of fixes from mvebu-land for v3.12.  Mostly
involving catching up the ReadyNAS 102 board from all the changes made
last merge window.  All three of those are fixing boot/reboot problems
with that board.

Jason's patch is fixing the case where the PCIe driver can continue with
a corrupted resource.

Also, we've noticed that the previous mvebu/fixes pull (tags/fixes-3.12)
made it into arm-soc/fixes, but hasn't made it into mainline.  Do you
intend to send a fixes pull to Linus in time for v3.12-rc4?

I only mention it because v3.12-rc3 still hangs at 'calibrating delay
loop' on the mirabox.  I thought the only fix needed for that made it
into v3.12-rc3 (through the clocksource tree), but apparently the two
fixes in arm-soc/fixes are needed as well.

thx,

Jason.


The following changes since commit ddf7e399024aa908573a08d6339cefa6253b83db:

  ARM: kirkwood: Fix address of second XOR engine (2013-09-20 03:16:20 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/fixes-3.12-2

for you to fetch changes up to 8553bcad3eca6cdd19c4771c378bd2cf6e25c6b2:

  bus: mvebu-mbus: Fix optional pcie-mem/io-aperture properties (2013-10-01 17:04:17 +0000)

----------------------------------------------------------------
mvebu fixes for v3.12 (round 2)

 - mvebu
    - fix ReadyNAS 102 power button (needs to be active high)
    - fix ReadyNAS 102 automated rebooting (prevent hang) by add gpio-poweroff
      node
    - fix booting ReadyNAS 102 by adding MBus ranges and PCIe DT nodes
    - mvebu-mbus: prevent PCIe driver from continuing with corrupted resource

----------------------------------------------------------------
Arnaud Ebalard (3):
      ARM: mvebu: fix ReadyNAS 102 Power button GPIO to make it active high
      ARM: mvebu: Add DT entry for ReadyNAS 102 to use gpio-poweroff driver
      ARM: mvebu: add missing DT Mbus ranges and relocate PCIe DT nodes for RN102

Jason Gunthorpe (1):
      bus: mvebu-mbus: Fix optional pcie-mem/io-aperture properties

 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 49 +++++++++++++++++---------
 drivers/bus/mvebu-mbus.c                       |  6 ++--
 2 files changed, 36 insertions(+), 19 deletions(-)
