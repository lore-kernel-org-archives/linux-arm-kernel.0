From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 May 2015 15:07:31 +0200
Subject: [PATCH v2 0/5] dmaengine: mv_xor: Fixes and enhancements
Message-ID: <1432645656-20504-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie is about various fixes and enhancements that were
previously submitted as part of the "ARM: mvebu: Add support for RAID6
PQ offloading" serie.

Seems the RAID6 PQ stuff seems more controversial than what I
expected, we took out the various bugs and enhancements patches, and
will submit the other patches as a separate set.

Changes from v1:
  - Moved the bugfix commit as the first commit and cc'd stable
  - Changed the Armada 38x compatible to armada-380-xor
  - Made some misc cleanups

Lior Amsalem (4):
  dmaengine: mv_xor: bug fix for racing condition in descriptors cleanup
  dmaengine: mv_xor: add support for a38x command in descriptor mode
  dmaengine: mv_xor: Enlarge descriptor pool size
  dmaengine: mv_xor: improve descriptors list handling and reduce
    locking

Maxime Ripard (1):
  dmaengine: mv_xor: Rename function for consistent naming

 Documentation/devicetree/bindings/dma/mv-xor.txt |   2 +-
 drivers/dma/mv_xor.c                             | 352 ++++++++++++-----------
 drivers/dma/mv_xor.h                             |  27 +-
 3 files changed, 206 insertions(+), 175 deletions(-)

-- 
2.4.1
