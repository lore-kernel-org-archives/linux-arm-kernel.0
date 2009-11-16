From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 16 Nov 2009 21:34:06 +0100
Subject: [PATCH 00/25] imx cleanups
Message-ID: <20091116203406.GA6546@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series is the start of a big cleanup of the imx support.  The
overall goal is to support all SoCs with a single image.  Therefor a few
things need to/should be done:

  - clean up headers not to define the same constants (i.e. prefix
    everything with the SoC's name)
  - generalise device creation
  - generalise static mappings
  - probably much more

Here I start with the first two items.

On the way I plan to change all occurences of "mxc" to "imx".

I hope this all can happen without much breakage.

For now no #defines are removed only redefined.  So all code should
continue to work as before.  Assuming this series is accepted new usage
of the #defines without a SoC-prefix should be deprecated.  When all
users are converted, the old #defines can go away.

git branch, shortlog and diffstat can be found below.  It merges nearly
fine into Sascha's mxc-master.  There's only a trivial conflict in
arch/arm/plat-mxc/Makefile .

Best regards
Uwe

The following changes since commit aa021baa3295fa6e3f367d80f8955dd5176656eb:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../mason/btrfs-unstable

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git imx

Uwe Kleine-K?nig (25):
      imx: reorder mx2x.h
      imx: reorder mx21.h
      imx: reorder mx27.h
      imx: reorder mx3x.h
      imx: add namespace prefixes for symbols in mx2x.h
      imx: add namespace prefixes for symbols in mx21.h
      imx: add namespace prefixes for symbols in mx27.h
      imx: add namespace prefixes for symbols in mx3x.h
      imx: add namespace prefixes for symbols in mx31.h
      imx: add namespace prefixes for symbols in mx35.h
      imx: reformat mx25.h to match the other platform includes
      imx: copy constants from mx2x.h to mx21.h using the appropriate namespace
      imx: copy constants from mx2x.h to mx27.h using the appropriate namespace
      imx: copy constants from mx3x.h to mx31.h using the appropriate namespace
      imx: copy constants from mx3x.h to mx35.h using the appropriate namespace
      imx: generalize nand device registration
      imx/eukrea_cpuimx27: use new nand device registration
      imx/mx21ads: use new nand device registration
      imx/mx27ads: use new nand device registration
      imx/pca100: use new nand device registration
      imx/pcm038: use new nand device registration
      imx/armadillo5x0: use new nand device registration
      imx/mx31lite: use new nand device registration
      imx/pcm037: use new nand device registration
      imx/mx25pdk: remove unused include

 arch/arm/mach-mx2/devices.h                     |    2 +
 arch/arm/mach-mx2/eukrea_cpuimx27.c             |   13 +-
 arch/arm/mach-mx2/mx21ads.c                     |   13 +-
 arch/arm/mach-mx2/mx27ads.c                     |   13 +-
 arch/arm/mach-mx2/pca100.c                      |   12 +-
 arch/arm/mach-mx2/pcm038.c                      |   13 +-
 arch/arm/mach-mx25/mx25pdk.c                    |    1 -
 arch/arm/mach-mx3/armadillo5x0.c                |   16 +-
 arch/arm/mach-mx3/devices.h                     |    1 +
 arch/arm/mach-mx3/mx31lite.c                    |   12 +-
 arch/arm/mach-mx3/pcm037.c                      |   12 +-
 arch/arm/mach-mxc91231/devices.h                |    2 +
 arch/arm/plat-mxc/Makefile                      |    2 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_nand.c   |   54 +++
 arch/arm/plat-mxc/include/mach/devices-common.h |   20 ++
 arch/arm/plat-mxc/include/mach/mx21.h           |  207 ++++++++++--
 arch/arm/plat-mxc/include/mach/mx25.h           |   10 +-
 arch/arm/plat-mxc/include/mach/mx27.h           |  315 ++++++++++++++----
 arch/arm/plat-mxc/include/mach/mx2x.h           |  339 ++++++++++++-------
 arch/arm/plat-mxc/include/mach/mx31.h           |  237 +++++++++++--
 arch/arm/plat-mxc/include/mach/mx35.h           |  201 ++++++++++-
 arch/arm/plat-mxc/include/mach/mx3x.h           |  413 +++++++++++++++--------
 23 files changed, 1438 insertions(+), 471 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/Makefile
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_nand.c
 create mode 100644 arch/arm/plat-mxc/include/mach/devices-common.h

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
