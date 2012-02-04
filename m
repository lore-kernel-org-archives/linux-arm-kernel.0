From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 4 Feb 2012 08:32:06 +0800
Subject: [GIT PULL v2] mxs/boards for v3.4
In-Reply-To: <20120131154051.GF26436@S2101-09.ap.freescale.net>
References: <20120131154051.GF26436@S2101-09.ap.freescale.net>
Message-ID: <20120204003203.GB28377@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 11:40:53PM +0800, Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> Please pull the following mxs board changes for v3.4.  It has no
> conflict with rmk/for-armsoc branch.
> 
Since you have not pulled it yet, I'm updating it as v2 with Lauri's
APX4 patch added.  Please pull.

Regards,
Shawn

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/boards

Fabio Estevam (2):
      ARM: mx28: Remove duplicate OCOTP error message
      ARM: mx28evk: Simplify GPIO requests

Lauri Hintsala (1):
      ARM: mxs: Add initial support for Bluegiga APX4 Development Kit

Shawn Guo (1):
      ARM: mxs: detect SoC by checking CHIPID register

Wolfram Sang (1):
      ARM: mxs: read correct values when setting up MAC

 arch/arm/mach-mxs/Kconfig                   |   16 ++
 arch/arm/mach-mxs/Makefile                  |    1 +
 arch/arm/mach-mxs/include/mach/digctl.h     |    1 +
 arch/arm/mach-mxs/include/mach/mxs.h        |   29 ++--
 arch/arm/mach-mxs/include/mach/uncompress.h |   13 +-
 arch/arm/mach-mxs/mach-apx4devkit.c         |  260 +++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-m28evk.c             |    7 +-
 arch/arm/mach-mxs/mach-mx28evk.c            |   80 ++-------
 8 files changed, 320 insertions(+), 87 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mach-apx4devkit.c
