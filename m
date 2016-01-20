From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 20 Jan 2016 17:20:18 +0800
Subject: [PATCH v2 0/4] net: mvneta: support more than one clk
Message-ID: <1453281622-7829-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms may provide more than one clk for the mvneta IP, for
example Marvell BG4CT provides "core" clk for the mac core, and "axi"
clk for the AXI bus logic.

This series tries to addess the "more than one clk" issue. Note: to
support BG4CT, we have lots of refactor work to do, eg. BG4CT doesn't
have mbus concept etc.

Since v1:
 - Add Thomas Acks to patch1 and patch2.
 - make sure the headers are really sorted (some headers are still
   unsorted in v1).
 - disable axi clk before disabling core clk, Thank Thomas.
 - update dt binding as Thomas suggested.


Jisheng Zhang (4):
  net: mvneta: sort the headers in alphabetic order
  net: mvneta: Try to get named core clock first
  net: mvneta: get optional axi clk
  net: mvneta: update clocks property and document additional
    clock-names

 .../bindings/net/marvell-armada-370-neta.txt       |  7 +++-
 drivers/net/ethernet/marvell/mvneta.c              | 38 ++++++++++++++--------
 2 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.7.0.rc3
