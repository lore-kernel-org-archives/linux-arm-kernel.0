From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jan 2013 13:12:48 +0000
Subject: [PATCH 00/18] AB8500 battery management series upgrade
Message-ID: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anton,

Here we go again. This patches include your suggested fixups.

Please find the next instalment of the AB8500 Power drivers upgrade.
A lot of work has taken place on the internal development track, but
little effort has gone into mainlining it. At last count there were
around 70+ patches which are in need of forward-porting, then
upstreaming. This patch-set aims to make a good start. :)

 drivers/power/Kconfig                |   15 +
 drivers/power/Makefile               |    1 +
 drivers/power/ab8500_bmdata.c        |   18 +-
 drivers/power/ab8500_btemp.c         |   27 +-
 drivers/power/ab8500_charger.c       |  359 ++++++--
 drivers/power/ab8500_fg.c            |  277 ++++--
 drivers/power/abx500_chargalg.c      |   30 +-
 drivers/power/pm2301_charger.c       | 1599 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/abx500.h           |    6 +-
 include/linux/mfd/abx500/ab8500-bm.h |   10 +
 include/linux/mfd/abx500/ab8500.h    |    5 +
 include/linux/pm2301_charger.h       |   60 ++
 12 files changed, 2259 insertions(+), 148 deletions(-)
