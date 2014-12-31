From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 31 Dec 2014 16:57:49 +0800
Subject: [PATCH 0/3] fix non-working eMMC on Marvell BG2Q DMP board
Message-ID: <1420016272-6789-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC on Marvell BG2Q DMP board doesn't work due to the following reasons:

 1. the sdhci2 host needs "core" clk to work.
 2. there's no card detection for the eMMC.
 3. the non-exist "smemc" clk occpuies the enable bit for nfc clock which is
    use for the sdhci2's "core" clk.

These pathes fix them.

Please consider for stable as well.

Jisheng Zhang (3):
  ARM: dts: berlin: fix io clk and add missing core clk for BG2Q sdhci2
    host
  ARM: berlin: add broken-cd and set bus width for eMMC in Marvell DMP
    DT
  clk: berlin: bg2q: remove non-exist "smemc" gate clock

 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 2 ++
 arch/arm/boot/dts/berlin2q.dtsi            | 3 ++-
 drivers/clk/berlin/bg2q.c                  | 1 -
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.1.4
