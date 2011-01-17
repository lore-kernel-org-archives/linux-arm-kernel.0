From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 17 Jan 2011 10:39:54 -0800
Subject: [GIT PULL] pxa: one fix and several simplification patches for -rc
Message-ID: <AANLkTi=2eS9YOMS8q9XuY-KSp7wpM=BXDxa4DSycxHP7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The commits below are good for .38, let me know if you are OK to
pull, or I can send them later in -rc1 phases.

The following changes since commit ea0c4f3ca8a55e7e3138c2c4b3e9f7fe34d3ecab:

  ARM: pxa: fix building issue of missing physmap.h (2011-01-15 04:29:21 -0600)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Bj?rn Forsman (1):
      ARM: pxa/colibri: use correct SD detect pin

Marek Vasut (9):
      ARM: pxa: PalmTE2: Use gpio arrays in backlight init
      ARM: pxa: Use gpio arrays in colibri_pcmcia driver
      ARM: pxa: Use gpio arrays in palmld_pcmcia driver
      ARM: pxa: Use gpio arrays in palmtc_pcmcia driver
      ARM: pxa: Use gpio arrays in palmtx_pcmcia driver
      ARM: pxa: Use gpio arrays in vpac270_pcmcia driver
      ARM: pxa: Use gpio arrays in palmld_hdd driver
      ARM: pxa: Update copyright notices for Palm devices
      ARM: pxa: PalmZ72: Add OV9640 camera support

 arch/arm/mach-pxa/colibri-evalboard.c    |    2 +-
 arch/arm/mach-pxa/colibri-pxa300.c       |    2 +-
 arch/arm/mach-pxa/include/mach/colibri.h |    2 +-
 arch/arm/mach-pxa/include/mach/palmz72.h |    5 +
 arch/arm/mach-pxa/palm27x.c              |    3 +-
 arch/arm/mach-pxa/palmte2.c              |   31 ++------
 arch/arm/mach-pxa/palmz72.c              |  127 ++++++++++++++++++++++++++++
 drivers/ata/pata_palmld.c                |   43 +++++-----
 drivers/pcmcia/pxa2xx_colibri.c          |  133 +++++++++++-------------------
 drivers/pcmcia/pxa2xx_palmld.c           |   42 ++-------
 drivers/pcmcia/pxa2xx_palmtc.c           |   75 +++--------------
 drivers/pcmcia/pxa2xx_palmtx.c           |   57 +++----------
 drivers/pcmcia/pxa2xx_vpac270.c          |  110 +++++++------------------
 13 files changed, 279 insertions(+), 353 deletions(-)
