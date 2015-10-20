From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 20 Oct 2015 19:16:43 +0800
Subject: [PATCH v2 0/4] berlin sdhci clock clean up
Message-ID: <1445339807-2351-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add or fix the optional clock property, then remove the CLK_IGNORE_UNUSED
flag for sdio clk(s).

Since v1:
  - remove the "mmc: sdhci-pxav3: fix optional clock name" patch to not
    block the clock clean up patches, will send another separate patch 
    after talking with HW people.

Jisheng Zhang (4):
  ARM: dts: berlin: correct BG2Q's sdhci2 2nd clock
  ARM: dts: berlin: add 2nd clock for BG2Q sdhci0 and sdhci1
  clk: berlin: bg2q: remove CLK_IGNORE_UNUSED flag for sdio clk
  clk: berlin: bg2: remove CLK_IGNORE_UNUSED flag for sdio clk

 arch/arm/boot/dts/berlin2q.dtsi | 8 +++++---
 drivers/clk/berlin/bg2.c        | 4 ++--
 drivers/clk/berlin/bg2q.c       | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.6.1
