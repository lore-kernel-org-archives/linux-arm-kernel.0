From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Thu, 11 Jun 2015 16:26:32 +0300
Subject: [PATCH 0/2] genalloc: rename dev_get_gen_pool() and
 of_get_named_gen_pool()
Message-ID: <1434029192-7082-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial nonfunctional change initially based on discussion
https://lkml.org/lkml/2015/6/8/588

Worth to mention that instead of the assumed new name
dev_gen_pool_get(), this change attempts to be more close to other
in-kernel interfaces and new function name is just gen_pool_get().

The change is based and tested on linux-next.

Vladimir Zapolskiy (2):
  genalloc: rename dev_get_gen_pool() to gen_pool_get()
  genalloc: rename of_get_named_gen_pool() to of_gen_pool_get()

 arch/arm/mach-at91/pm.c                   |  2 +-
 arch/arm/mach-imx/pm-imx5.c               |  2 +-
 arch/arm/mach-imx/pm-imx6.c               |  2 +-
 drivers/dma/mmp_tdma.c                    |  2 +-
 drivers/media/platform/coda/coda-common.c |  4 ++--
 include/linux/genalloc.h                  |  6 +++---
 lib/genalloc.c                            | 14 +++++++-------
 sound/core/memalloc.c                     |  2 +-
 8 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.1.4
