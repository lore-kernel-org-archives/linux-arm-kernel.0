From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 20 Jan 2016 16:06:19 +0800
Subject: [PATCH 0/4] net: mvneta: support more than one clk
Message-ID: <1453277183-5412-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms may provide more than one clk for the mvneta IP, for
example Marvell BG4CT provides "core" clk for the mac core, and "axi"
clk for the AXI bus logic.

This series tries to addess the "more than one clk" issue. Note: to
support BG4CT, we have lots of refactor work to do, eg. BG4CT doesn't
have mbus concept etc.

Jisheng Zhang (4):
  net: mvneta: sort the headers in alphabetic order
  net: mvneta: Try to get named core clock first
  net: mvneta: mmc: get optional axi clk
  net: mvneta: update clocks property and document additional
    clock-names

 .../bindings/net/marvell-armada-370-neta.txt       |  6 +++-
 drivers/net/ethernet/marvell/mvneta.c              | 36 ++++++++++++++--------
 2 files changed, 28 insertions(+), 14 deletions(-)

-- 
2.7.0.rc3
