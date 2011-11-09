From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 9 Nov 2011 11:38:37 +0100
Subject: [PATCH 0/6] PL022 updates
Message-ID: <1320835117-31168-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This set consists of the previously submitted patches [1/6]
thru [4/6] rebased on top of v3.2-rc1 and two new patches
from Chris [5/6] and [6/6].

There is a pending clk_enable fix in Russell's tree but I don't
think these patches collide with that fix.

Chris Blair (3):
  spi/pl022: only enable RX interrupts when TX is complete
  spi/pl022: move device disable to workqueue thread
  spi/pl022: add support for pm_runtime autosuspend

Jonas Aaberg (1):
  spi/pl022: fix build warnings

Virupax Sadashivpetimath (2):
  spi/pl022: disable the PL022 block when unused
  spi/pl022: skip default configuration before suspending

 drivers/spi/spi-pl022.c    |   69 ++++++++++++++++++++++++++++++--------------
 include/linux/amba/pl022.h |    4 ++
 2 files changed, 51 insertions(+), 22 deletions(-)

-- 
1.7.3.2
