From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 May 2014 11:45:18 -0400
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.16 (incr. #2)
Message-ID: <20140522154518.GS8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's the last round of SoC changes for v3.16.  They haven't been in
-next as long as I would like, but they are needed for v3.16.

As usual, this is an incremental pull request from tags/mvebu-soc-3.16
to tags/mvebu-soc-3.16-2 in the mvebu/soc branch.

Please pull.

thx,

Jason.


The following changes since commit 9f0affcf3e21fc56d8bce625bb3d5800b7a7d284:

  ARM: mvebu: Fix pmsu compilation when ARMv6 is selected (2014-05-08 16:55:55 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.16-2

for you to fetch changes up to 07ae144be1b2ac45f893bc1ed3fe1a49f7128e46:

  ARM: mvebu: returns ll_get_cpuid() to ll_get_coherency_cpumask() (2014-05-22 14:26:30 +0000)

----------------------------------------------------------------
mvebu SoC changes for v3.16 (incremental #2)

 - mvebu
    - fix coherency on big-endian in -next
    - hardware IO coherency
    - L2/PCIe deadlock workaround
    - small coherency cleanups

----------------------------------------------------------------
Thomas Petazzoni (7):
      ARM: mvebu: use hardware I/O coherency also for PCI devices
      ARM: mvebu: implement L2/PCIe deadlock workaround
      ARM: mvebu: coherency: fix registration of PCI bus notifier when !PCI
      ARM: mvebu: fix big endian booting after coherency code rework
      ARM: mvebu: fix indentation of assembly instructions in coherency_ll.S
      ARM: mvebu: improve comments in coherency_ll.S
      ARM: mvebu: returns ll_get_cpuid() to ll_get_coherency_cpumask()

 arch/arm/mach-mvebu/coherency.c    | 62 +++++++++++++++++++++++++++---
 arch/arm/mach-mvebu/coherency_ll.S | 77 ++++++++++++++++++++++++--------------
 2 files changed, 106 insertions(+), 33 deletions(-)
