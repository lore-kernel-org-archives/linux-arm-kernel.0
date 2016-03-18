From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Fri, 18 Mar 2016 10:26:06 +0800
Subject: [PATCH v2 0/1] arm64/dma-mapping: reduce an unnecessary conversion
 for coherent DMA
Message-ID: <1458267967-6332-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v1 -> v2:
1. Give up removing the conversion, because of thoughtless, instead moved it
into branch if (!is_device_dma_coherent(dev)). Thanks for Catalin's detailed
explanation, I directly take some relies as comment in the code.

Zhen Lei (1):
  arm64/dma-mapping: reduce an unnecessary conversion for coherent DMA

 arch/arm64/mm/dma-mapping.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.5.0
