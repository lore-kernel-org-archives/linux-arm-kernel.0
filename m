From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  7 Oct 2015 13:23:26 +0100
Subject: [PATCH v2 0/3] hwrng: st: Couple of improvements
Message-ID: <1444220609-31251-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set contains a minor documentation fix, greater clarification
with how the FIFO depth/size is represented and finally a fix to
prevent early timeout during data acquisition.

v1 => v2:
 - Remove phantom bugfix (FIFO really is 4 deep, not 8)
 - Double timeout value to account for inconsistent call to udelay()
   - Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>

Lee Jones (3):
  hwrng: st: dt: Fix trivial typo in node address
  hwrng: st: Use real-world device timings for timeout
  hwrng: st: Improve FIFO size/depth description

 Documentation/devicetree/bindings/rng/st,rng.txt |  2 +-
 drivers/char/hw_random/st-rng.c                  | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
1.9.1
