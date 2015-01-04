From: jszhang@marvell.com (Jisheng Zhang)
Date: Sun, 4 Jan 2015 23:15:46 +0800
Subject: [PATCH next 0/2] mmc: sdhci-pxav3: fix unbalanced pm and clock issues
Message-ID: <1420384548-7816-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches fix unbalanced pm and clock issues. The clock unbalance
issue would cause power consumption regression because the clock will never
be gated at runtime PM suspend.

Jisheng Zhang (2):
  mmc: sdhci-pxav3: fix unbalanced clock issues during probe
  mmc: sdhci-pxav3: fix pm unbalanced issue in -> remove()

 drivers/mmc/host/sdhci-pxav3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.1.4
