From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Jan 2015 13:08:19 -0800
Subject: [GIT PULL 2/2] omap changes to make dm816x usable
In-Reply-To: <pull-1422306429-777451>
References: <pull-1422306429-777451>
Message-ID: <pull-1422306429-777451-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 13efcb188984f69e1f97b4d9e7d3663fb782946f:

  ARM: OMAP2+: Disable omap3 PM init for ti81xx (2015-01-14 17:37:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/dm816x-data

for you to fetch changes up to 4d38bd1237f5bb67c3d5d183fc41db4bf4dbfb6b:

  ARM: OMAP2+: Add dm816x hwmod support (2015-01-26 09:26:32 -0800)

----------------------------------------------------------------
Patches to add necessary SoC related clockdomain and interconnect
data  to make dm816x boot with basic devices. This finally gets
dm816x into a usable shape for further work to happen after a few
years of stalled effort of making this SoC to work with the mainline
kernel.

As most of the devices are similar to the other omap variants, we
get at least serial, MMC, Ethernet, I2C, EDMA, pinctrl, SPI and GPMC
working for these SoCs with the related device tree changes.

----------------------------------------------------------------
Aida Mynzhasova (1):
      ARM: OMAP2+: Add clock domain support for dm816x

Tony Lindgren (2):
      ARM: OMAP2+: Add board-generic.c entry for ti81xx
      ARM: OMAP2+: Add dm816x hwmod support

 arch/arm/mach-omap2/Makefile                |    4 +
 arch/arm/mach-omap2/board-generic.c         |   36 +
 arch/arm/mach-omap2/clockdomain.h           |    1 +
 arch/arm/mach-omap2/clockdomains81xx_data.c |  194 +++++
 arch/arm/mach-omap2/cm81xx.h                |   61 ++
 arch/arm/mach-omap2/io.c                    |   82 +-
 arch/arm/mach-omap2/omap_hwmod.c            |    2 +-
 arch/arm/mach-omap2/omap_hwmod.h            |    1 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 1136 +++++++++++++++++++++++++++
 9 files changed, 1478 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains81xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm81xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_81xx_data.c
