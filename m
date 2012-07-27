From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Jul 2012 13:38:47 +0100
Subject: [PATCH 0/7] Bugfixes and clean-ups bound for the v3.6 RCs
Message-ID: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set includes some important changes which should make
their way to the Mainline Release Candidates for the v3.6 release.
Without them Audio doesn't even probe (at all) when booting with
Device Tree selected. The kernel can't compile with ux500 audio
enabled. Also platform data will fail to reach the AB8500 CODEC
driver. Even if we can get that far SoC Core will assume we're
using regmaps and attempt to use them; however, none exist for
this driver, so the kernel will oops.

 arch/arm/mach-ux500/board-mop500-msp.c |    2 +-
 arch/arm/mach-ux500/board-mop500.c     |    9 ++++-----
 drivers/mfd/ab8500-core.c              |    1 +
 drivers/mfd/db8500-prcmu.c             |    1 +
 sound/soc/codecs/ab8500-codec.c        |    4 ++++
 sound/soc/soc-dapm.c                   |    2 --
 6 files changed, 11 insertions(+), 8 deletions(-)
