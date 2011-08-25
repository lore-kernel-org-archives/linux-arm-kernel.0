From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Thu, 25 Aug 2011 14:26:13 +0800
Subject: [PATCH v3 0/2] mmc add vsdio to dynamically control sdio power
Message-ID: <1314253575-2602-1-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2->v3, change vmmc to vsdio
In v2, vmmc is reused, however, sd may be impacted if move vmmc to set_ios.
When no card inserted, CD is high, vmmc will be disabled when detect fail, CD will pull low accordingly, controller may treat as card inserted and re-detect.

Zhangfei Gao (2):
  mmc: sdio add regulator vsdio
  ARM: mmp2: support sdio with regulator vsdio

 arch/arm/mach-mmp/brownstone.c |   60 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c       |   22 ++++++++++++++
 include/linux/mmc/sdhci.h      |    2 +
 3 files changed, 82 insertions(+), 2 deletions(-)
