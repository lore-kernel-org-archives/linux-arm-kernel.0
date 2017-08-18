From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 16:48:03 +0200
Subject: [GIT PULL 2/5] soc/tegra: Changes for v4.14-rc1
In-Reply-To: <20170818144806.14252-1-thierry.reding@gmail.com>
References: <20170818144806.14252-1-thierry.reding@gmail.com>
Message-ID: <20170818144806.14252-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.14-soc

for you to fetch changes up to 27a0342ac162bf2ba30c288cfb7b72eabed38d8b:

  soc/tegra: Register SoC device (2017-08-17 16:43:13 +0200)

----------------------------------------------------------------
soc/tegra: Changes for v4.14-rc1

Contains a fix for unbalanced reference counting of device tree nodes in
the PMC-based generic power domains code.

A second change moves the SoC device registration code from its old
location in arch/arm/mach-tegra to drivers/soc/tegra so that it can be
shared between 32-bit and 64-bit ARM Tegra SoCs.

----------------------------------------------------------------
Thierry Reding (1):
      soc/tegra: Register SoC device

Tuomas Tynkkynen (1):
      soc/tegra: Fix bad of_node_put() in powergate init

 arch/arm/mach-tegra/tegra.c         | 29 +---------------------
 drivers/soc/tegra/Kconfig           |  5 ++++
 drivers/soc/tegra/fuse/fuse-tegra.c | 48 +++++++++++++++++++++++++++++++++++--
 drivers/soc/tegra/pmc.c             |  4 +---
 include/soc/tegra/fuse.h            |  2 ++
 5 files changed, 55 insertions(+), 33 deletions(-)
