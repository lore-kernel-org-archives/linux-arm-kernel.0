From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Aug 2012 12:47:25 +0200
Subject: [PATCH 0/3] Add code for setting coherent pool size
Message-ID: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Aaro Koskinen and Josh Coombs reported that commit e9da6e9905e639 ("ARM:
dma-mapping: remove custom consistent dma region") introduced a
regresion. It turned out that the default 256KiB for atomic coherent
pool might not be enough. After that patch, some Kirkwood systems run
out of atomic coherent memory and fail without any meanfull message.

This patch series is an attempt to fix those issues by adding function
for setting coherent pool size from platform initialization code and
increasing the size of the pool for Kirkwood systems.

Best regards
Marek Szyprowski
Samsung Poland R&D Center

Patch summary:

Marek Szyprowski (3):
  ARM: DMA-Mapping: add function for setting coherent pool size from
    platform code
  ARM: DMA-Mapping: print warning when atomic coherent allocation fails
  ARM: Kirkwood: increase atomic coherent pool size

 arch/arm/include/asm/dma-mapping.h |    7 +++++++
 arch/arm/mach-kirkwood/common.c    |    7 +++++++
 arch/arm/mm/dma-mapping.c          |   22 +++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletions(-)

-- 
1.7.1.569.g6f426
