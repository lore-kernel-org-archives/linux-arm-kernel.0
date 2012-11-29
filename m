From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Thu, 29 Nov 2012 12:45:04 -0800
Subject: [PATCH 0/6] drivers: convert struct spinlock to spinlock_t
Message-ID: <1354221910-22493-1-git-send-email-mcgrof@do-not-panic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Turns out a few drivers have strayed away from using the
spinlock_t typedef and decided to use struct spinlock
directly. This series converts these drivers to use
spinlock_t. Each change has been compile tested with
allmodconfig and sparse checked. Driver developers
may want to look at the compile error output / sparse
error report supplied in each commit log, in particular
brcmfmac and i915, there are quite a few things that
are not related to this change that the developers
can clean up / fix.

Luis R. Rodriguez (6):
  ux500: convert struct spinlock to spinlock_t
  i915: convert struct spinlock to spinlock_t
  s5p-fimc: convert struct spinlock to spinlock_t
  s5p-jpeg: convert struct spinlock to spinlock_t
  brcmfmac: convert struct spinlock to spinlock_t
  ie6xx_wdt: convert struct spinlock to spinlock_t

 drivers/crypto/ux500/cryp/cryp.h               |    4 ++--
 drivers/crypto/ux500/hash/hash_alg.h           |    4 ++--
 drivers/gpu/drm/i915/i915_drv.h                |    4 ++--
 drivers/media/platform/s5p-fimc/mipi-csis.c    |    2 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.h    |    2 +-
 drivers/net/wireless/brcm80211/brcmfmac/fweh.h |    2 +-
 drivers/watchdog/ie6xx_wdt.c                   |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.7.10.4
