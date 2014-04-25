From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Apr 2014 18:34:11 +0100
Subject: [PATCH 0/3] arm64: Default to non-coherent DMA ops
Message-ID: <1398447254-18527-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following recent discussions and patch from Ritesh, I'm planning to
align the default DMA ops with 32-bit arm and make them non-coherent. In
addition, we need to make sure that devices marked explicitly as
coherent use the correct dma ops. Until Santosh's DMA patches get
reviewed/merged, the temporary solution is bus notifiers which check the
"dma-coherent" property and set the right dma ops.

Catalin Marinas (2):
  arm64: Use bus notifiers to set per-device coherent DMA ops
  arm64: Mark the Applied Micro X-Gene SATA controller as DMA coherent

Ritesh Harjani (1):
  arm64: Make default dma_ops to be noncoherent

 .../devicetree/bindings/ata/apm-xgene.txt          |  3 ++
 arch/arm64/boot/dts/apm-storm.dtsi                 |  3 ++
 arch/arm64/kernel/setup.c                          |  2 +-
 arch/arm64/mm/dma-mapping.c                        | 35 ++++++++++++++++++++--
 4 files changed, 40 insertions(+), 3 deletions(-)
