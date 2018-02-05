From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 5 Feb 2018 14:06:18 -0600
Subject: [PATCH v2 0/8] use 64-bit arithmetic instead of 32-bit
Message-ID: <cover.1517856716.git.gustavo@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add suffix LL and ULL to various constants in order to give the compiler
complete information about the proper arithmetic to use. Such constants
are used in contexts that expect expressions of type u64 (64 bits, unsigned)
and s64 (64 bits, signed).

The mentioned expressions are currently being evaluated using 32-bit
arithmetic, wich is some cases can lead to unintentional integer
overflows.

This patchset addresses the following Coverity IDs:
CIDs: 200604, 1056807, 1056808, 1271223, 1324146
CIDs: 1392628, 1392630, 1446589, 1454996, 1458347

Thank you

Changes in v2:
 - Update subject and changelog to better reflect the proposed code changes.
 - Add suffix ULL and LL to constants instead of casting variables.
 - Extend the proposed code changes to other similar cases that had not
   previously been considered in v1 of this patchset.

Gustavo A. R. Silva (8):
  rtl2832: use 64-bit arithmetic instead of 32-bit in
    rtl2832_set_frontend
  dvb-frontends: ves1820: use 64-bit arithmetic instead of 32-bit
  i2c: max2175: use 64-bit arithmetic instead of 32-bit
  i2c: ov9650: use 64-bit arithmetic instead of 32-bit
  pci: cx88-input: use 64-bit arithmetic instead of 32-bit
  rockchip/rga: use 64-bit arithmetic instead of 32-bit
  platform: sh_veu: use 64-bit arithmetic instead of 32-bit
  platform: vivid-cec: use 64-bit arithmetic instead of 32-bit

 drivers/media/dvb-frontends/rtl2832.c         |  4 ++--
 drivers/media/dvb-frontends/ves1820.c         |  2 +-
 drivers/media/i2c/max2175.c                   |  2 +-
 drivers/media/i2c/ov9650.c                    |  9 +++++----
 drivers/media/pci/cx88/cx88-input.c           |  4 ++--
 drivers/media/platform/rockchip/rga/rga-buf.c |  3 ++-
 drivers/media/platform/sh_veu.c               |  4 ++--
 drivers/media/platform/vivid/vivid-cec.c      | 11 +++++++++--
 8 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.7.4
