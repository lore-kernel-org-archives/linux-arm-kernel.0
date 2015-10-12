From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 12 Oct 2015 13:46:31 +0800
Subject: [PATCH 0/5] fix sdhci-pxav3 clock name and berlin clk clean up
Message-ID: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdhci-pxav3's clock name isn't correct. The current "io" clock is really
the PXAv3 SDHCI IP's "core" clock which is manadatory. The current "core"
clock is really the IP's "axi" clock which is optional. We fix this in patch1.

The following patches add the axi clock properties to bg2q dtsi, then remove
the CLK_IGNORE_UNUSED flag for sdio clk(s).

Jisheng Zhang (5):
  mmc: sdhci-pxav3: fix optional clock name
  ARM: dts: berlin: correct BG2Q's sdhci2 axi clock
  ARM: dts: berlin: add axi clock for BG2Q sdhci0 and sdhci1
  clk: berlin: bg2q: remove CLK_IGNORE_UNUSED flag for sdio clk
  clk: berlin: bg2: remove CLK_IGNORE_UNUSED flag for sdio clk

 .../devicetree/bindings/mmc/sdhci-pxa.txt          |  8 ++---
 arch/arm/boot/dts/berlin2.dtsi                     |  6 ++--
 arch/arm/boot/dts/berlin2cd.dtsi                   |  2 +-
 arch/arm/boot/dts/berlin2q.dtsi                    | 10 +++---
 drivers/clk/berlin/bg2.c                           |  4 +--
 drivers/clk/berlin/bg2q.c                          |  2 +-
 drivers/mmc/host/sdhci-pxav3.c                     | 40 +++++++++++-----------
 7 files changed, 37 insertions(+), 35 deletions(-)

-- 
2.6.1
