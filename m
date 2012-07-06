From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Fri, 06 Jul 2012 13:55:25 +0900
Subject: [PATCH 0/3] hwspinlock: a bug fix, trivial changes
Message-ID: <4FF66FBD.5090601@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

Recently I wrote a hwspinlock driver for our devices, and during
the review and debug process, we found a bug in the core code.
Could you take a look please?

The first patch is a bug fix.  The latter two patches are what I
think nice-to-have.  If you find useful, just take it, thanks!


Shinya Kuribayashi (3):
      hwspinlock/core: use global ID to register hwspinlocks on multiple devices
      hwspinlock/core: add notes on lock element in 'struct hwspinlock'
      hwspinlock/core: allow hwspinlock_device to have bank-specific private data

 drivers/hwspinlock/hwspinlock_core.c     | 2 +-
 drivers/hwspinlock/hwspinlock_internal.h | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
Shinya Kuribayashi
Renesas Electronics
