From: hch@lst.de (Christoph Hellwig)
Date: Mon,  5 Nov 2018 13:19:22 +0100
Subject: move the arm arch_dma_alloc implementation to common code
Message-ID: <20181105121931.13481-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series moves the existing arm64 implementation of arch_dma_alloc and
arch_dma_free to common code given that it is not arm64-specific, and
then also uses it for csky.  Given how many architectures remap memory
for the DMA coherent implementation it should be usable for many more,
and the new cache flushing hook and the generic atomic pool are also
enablers for implementing the IOMMU API dma ops in common code in a
follow on series.
