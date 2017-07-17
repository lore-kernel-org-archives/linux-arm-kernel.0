From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 17 Jul 2017 09:58:03 +0100
Subject: [RFC PATCH 0/2] Introduce interface for default DMA pool
Message-ID: <1500281885-3034-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is follow-up for Christoph complain of overloading the current
dma coherent infrastructure with the global pool. To address that I
implemented Robin's idea of the new interface to the global pool and
wire up it with (only existent user) ARM NOMMU.  Since I have not
heard from Vitaly and/or George of their use of global pool, I'm
leaving ARM MMU part to them.

[1] https://lkml.org/lkml/2017/7/7/370

Vladimir Murzin (2):
  drivers: dma-coherent: Introduce interface for default DMA pool
  ARM: NOMMU: Wire-up default DMA interface

 arch/arm/mm/dma-mapping-nommu.c |  45 +++++++++---
 drivers/base/dma-coherent.c     | 159 ++++++++++++++++++++++++++--------------
 include/linux/dma-mapping.h     |  24 ++++++
 3 files changed, 166 insertions(+), 62 deletions(-)

-- 
2.0.0
