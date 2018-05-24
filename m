From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Thu, 24 May 2018 15:19:05 +0100
Subject: [PATCH v2 0/5] crypto: ccree: cleanup, fixes and R-Car enabling
Message-ID: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set enables the use of CryptoCell found in some Renesas R-Car
Salvator-X boards and fixes some driver issues uncovered that prevented
to work properly.

Changes from v1:
- Properly fix the bug that caused us to read a bad signature register
  rather than dropping the check
- Proper DT fields as indicated by Geert Uytterhoeven.
- Better clock enabling as suggested by Geert Uytterhoeven.

Note! the last two patches in the set depend on the
"clk: renesas: r8a7795: Add CR clock" patch from Geert Uytterhoeven.

Gilad Ben-Yossef (5):
  crypto: ccree: correct host regs offset
  crypto: ccree: better clock handling
  crypto: ccree: silence debug prints
  clk: renesas: r8a7795: add ccree clock bindings
  arm64: dts: renesas: r8a7795: add ccree binding

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |  9 +++++++++
 drivers/clk/renesas/r8a7795-cpg-mssr.c   |  1 +
 drivers/crypto/ccree/cc_debugfs.c        |  7 +++++--
 drivers/crypto/ccree/cc_driver.c         | 34 ++++++++++++++++++++++++++------
 drivers/crypto/ccree/cc_driver.h         |  2 ++
 drivers/crypto/ccree/cc_host_regs.h      |  6 ++++--
 6 files changed, 49 insertions(+), 10 deletions(-)

-- 
2.7.4
