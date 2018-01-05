From: david@lechnology.com (David Lechner)
Date: Thu,  4 Jan 2018 18:38:05 -0600
Subject: [PATCH 0/7] clk: add helper functions for managing clk_onecell_data
Message-ID: <1515112695-3160-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am writing some clock drivers that use struct clk_onecell_data a few
times, so I decided to write a helper function to allocate the memory
since it is a two step process and can be tedious. Then I noticed that
mediatek already had such a helper function, so I have moved that to the
clk core and made use of it in other drivers where possible.

David Lechner (7):
  clk: add helper function for allocating clk_onecell_data
  clk: mediatek: make use of clk_alloc_onecell_data()
  clk: qoriq: make use of clk_alloc_onecell_data()
  clk: hisilicon: make use of clk_alloc_onecell_data()
  clk: rockchip: make use of clk_alloc_onecell_data()
  clk: st: make use of clk_alloc_onecell_data()
  clk: sunxi: make use of clk_alloc_onecell_data()

 drivers/clk/clk-qoriq.c                  | 13 +++------
 drivers/clk/clk.c                        | 49 ++++++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk-hi3620.c       |  7 +----
 drivers/clk/mediatek/clk-mt2701-bdp.c    |  2 +-
 drivers/clk/mediatek/clk-mt2701-eth.c    |  2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c    |  2 +-
 drivers/clk/mediatek/clk-mt2701-img.c    |  2 +-
 drivers/clk/mediatek/clk-mt2701-mm.c     |  2 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c   |  2 +-
 drivers/clk/mediatek/clk-mt2701.c        | 10 +++----
 drivers/clk/mediatek/clk-mt2712-bdp.c    |  2 +-
 drivers/clk/mediatek/clk-mt2712-img.c    |  2 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c |  2 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c    |  2 +-
 drivers/clk/mediatek/clk-mt2712-mm.c     |  2 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c   |  2 +-
 drivers/clk/mediatek/clk-mt2712-venc.c   |  2 +-
 drivers/clk/mediatek/clk-mt2712.c        | 12 ++++----
 drivers/clk/mediatek/clk-mt6797-img.c    |  2 +-
 drivers/clk/mediatek/clk-mt6797-mm.c     |  2 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c   |  2 +-
 drivers/clk/mediatek/clk-mt6797-venc.c   |  2 +-
 drivers/clk/mediatek/clk-mt6797.c        |  8 +++---
 drivers/clk/mediatek/clk-mt7622-aud.c    |  2 +-
 drivers/clk/mediatek/clk-mt7622-eth.c    |  4 +--
 drivers/clk/mediatek/clk-mt7622-hif.c    |  4 +--
 drivers/clk/mediatek/clk-mt7622.c        |  8 +++---
 drivers/clk/mediatek/clk-mt8135.c        |  8 +++---
 drivers/clk/mediatek/clk-mt8173.c        | 18 ++++++------
 drivers/clk/mediatek/clk-mtk.c           | 25 ----------------
 drivers/clk/mediatek/clk-mtk.h           |  2 --
 drivers/clk/rockchip/clk-rockchip.c      | 11 +------
 drivers/clk/st/clk-flexgen.c             | 17 ++++-------
 drivers/clk/st/clkgen-fsyn.c             | 11 +------
 drivers/clk/st/clkgen-pll.c              | 12 ++------
 drivers/clk/sunxi/clk-a10-pll2.c         | 14 +++------
 drivers/clk/sunxi/clk-mod0.c             | 13 ++-------
 drivers/clk/sunxi/clk-simple-gates.c     | 13 ++-------
 drivers/clk/sunxi/clk-sun8i-bus-gates.c  | 13 ++-------
 drivers/clk/sunxi/clk-sunxi.c            | 14 +++------
 drivers/clk/sunxi/clk-usb.c              |  8 +-----
 include/linux/clk-provider.h             |  3 ++
 42 files changed, 138 insertions(+), 195 deletions(-)

-- 
2.7.4
