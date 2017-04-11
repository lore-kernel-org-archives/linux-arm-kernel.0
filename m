From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Tue, 11 Apr 2017 15:54:10 +0100
Subject: [PATCH 0/5] Memory hotplug support for arm64 - complete patchset
Message-ID: <cover.1491920513.git.ar@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this is a follow up to the patch we previously released here [1].
We are publishing new memory hot-remove support for arm64 memory hotplug,
which complements our initial hot-add patch.

For convenience, we are reposting in a single thread all the 5 patches
that compose the full memory hot-plug support, which are:
- The initial patchset by Scott Branden, orginally released in [2]
  (2 patches).
- A second version of our hot-add patch, originally released in [1]
  (1 patch).
- New hot-remove support complementing the hot-add patch. (2 patches).

The patches should apply cleanly on Linux 4.11-rc6
(commit: 39da7c509acff13fc8cb12ec1bb20337c988ed36).

We have performed tests and experiments on physical and emulated boards
and we are collecting results (along with more information) at the public
Web page at [3].

Any comments or feedback are, as usual, very much appreciated.

[1] https://lkml.org/lkml/2016/12/14/188
[2] https://lkml.org/lkml/2016/12/1/811
[3] https://hotplug-tests.eu-gb.mybluemix.net

Andrea Reale (2):
  Hot-remove implementation for arm64
  Add "remove" probe driver for memory hot-remove

Maciej Bielski (1):
  Memory hotplug support for arm64 platform (v2)

Scott Branden (2):
  arm64: memory-hotplug: Add MEMORY_HOTPLUG, MEMORY_HOTREMOVE,
    MEMORY_PROBE
  arm64: defconfig: enable MEMORY_HOTPLUG config options

 arch/arm64/Kconfig               |  11 ++
 arch/arm64/configs/defconfig     |   3 +
 arch/arm64/include/asm/mmu.h     |   7 +
 arch/arm64/include/asm/pgtable.h |  15 ++
 arch/arm64/mm/init.c             | 113 +++++++++++
 arch/arm64/mm/mmu.c              | 417 +++++++++++++++++++++++++++++++++++++++
 drivers/base/memory.c            |  34 +++-
 include/linux/memblock.h         |   1 +
 mm/memblock.c                    |  10 +
 9 files changed, 610 insertions(+), 1 deletion(-)

-- 
1.9.1
