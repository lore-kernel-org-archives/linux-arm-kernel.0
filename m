From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 23 Mar 2017 16:21:04 +0530
Subject: [GIT PULL 1/3]: DaVinci SoC updates for v4.12
Message-ID: <20170323105106.20144-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.12/soc

for you to fetch changes up to 99228481331cdd75981767b23b83ef0ca7aa11da:

  ARM: davinci: add pdata-quirks for da850-evm vpif display (2017-03-07 16:43:19 +0530)

----------------------------------------------------------------
v4.12 SoC updates for DaVinci include necessary pdata-quirks
to make video capture and display work on da850.

VPIF driver which supports video capture and display on
da850 is a legacy driver.  It does not have DT equavalents
for all things that are used on platform data.

Attempts were made to pass data via DT[1], but linux-media
does not yet have a good way of describing subdevices in
device tree. This is work in progress. As soon as bindings
are defined and implementation is available, we can shift
to using that. For now we are stuck with using pdata.

The pull request also has some clean-up for PM, and a fix
for pdata quirks mechanism.

[1] https://marc.info/?l=devicetree&m=147982998517384

----------------------------------------------------------------
Bartosz Golaszewski (3):
      ARM: davinci: allow having multiple pdata-quirks
      ARM: da850-evm: add a fixed regulator for the UI board IO expander
      ARM: davinci: add pdata-quirks for da850-evm vpif display

Geert Uytterhoeven (1):
      ARM: davinci: PM: Drop useless check for PM_SUSPEND_STANDBY

Kevin Hilman (3):
      ARM: davinci: board-da850-evm: add I2C ID for VPIF
      ARM: davinci: da8xx: add OF_DEV_AUXDATA() for vpif
      ARM: davinci: da8xx: add pdata-quirks for VPIF capture

 arch/arm/mach-davinci/board-da850-evm.c |   4 +
 arch/arm/mach-davinci/da8xx-dt.c        |   1 +
 arch/arm/mach-davinci/pdata-quirks.c    | 178 +++++++++++++++++++++++++++++++-
 arch/arm/mach-davinci/pm.c              |   1 -
 4 files changed, 182 insertions(+), 2 deletions(-)
