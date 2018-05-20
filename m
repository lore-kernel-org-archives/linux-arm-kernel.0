From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 22:57:57 +0800
Subject: [GIT PULL 1/5] i.MX drivers updates for 4.18
Message-ID: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.18

for you to fetch changes up to f54e714cfc53b9164d1206f9ee49042195532a51:

  soc: imx: gpc: Do not pass static memory as platform data (2018-04-23 17:03:15 +0800)

----------------------------------------------------------------
i.MX drivers update for 4.18:
 - Use platform_device_add_data() instead of a pointer to a static
   memory in gpc/gpcv2 driver for platform data passing, so that we
   can avoid a BUG() when calling platform_device_put().

----------------------------------------------------------------
Andrey Smirnov (2):
      soc: imx: gpcv2: Do not pass static memory as platform data
      soc: imx: gpc: Do not pass static memory as platform data

 drivers/soc/imx/gpc.c   | 18 +++++++++++++-----
 drivers/soc/imx/gpcv2.c | 22 +++++++++++++++-------
 2 files changed, 28 insertions(+), 12 deletions(-)
