From: sboyd@kernel.org (Stephen Boyd)
Date: Tue,  6 Nov 2018 10:36:05 -0800
Subject: [PATCH 0/4] Simplify mediatek clk driver probes
Message-ID: <20181106183609.207702-1-sboyd@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I suggested this some time ago but nobody has gotten around to doing it
so far. Well now I have! Here's a patch series that cuts down the
boiler-plate code that Mediatek clk drivers have to multiplex probe
amongst the device match data.

Rob/Frank, I'd prefer to take the first patch via clk tree so I can
merge it all in the next release. Otherwise, I can pull a stable commit
and merge it that way in case you want to take it through your tree.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>

Stephen Boyd (4):
  of/device: Add a way to probe drivers by match data
  clk: mediatek: Convert to platform_driver_probe_by_match_data()
  clk: mediatek: Drop THIS_MODULE from platform_driver
  clk: mediatek: Simplify single driver probes

 drivers/clk/mediatek/clk-mt2701-g3d.c | 28 +++---------------------
 drivers/clk/mediatek/clk-mt2701.c     | 20 +----------------
 drivers/clk/mediatek/clk-mt2712.c     | 21 +-----------------
 drivers/clk/mediatek/clk-mt6797.c     | 20 +----------------
 drivers/clk/mediatek/clk-mt7622-aud.c | 28 +++---------------------
 drivers/clk/mediatek/clk-mt7622-eth.c | 20 +----------------
 drivers/clk/mediatek/clk-mt7622-hif.c | 20 +----------------
 drivers/clk/mediatek/clk-mt7622.c     | 20 +----------------
 drivers/of/device.c                   | 31 +++++++++++++++++++++++++++
 include/linux/of_device.h             |  1 +
 10 files changed, 44 insertions(+), 165 deletions(-)

-- 
Sent by a computer through tubes
