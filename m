From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Wed, 11 Jan 2017 16:41:20 +0300
Subject: [PATCH] arm64: avoid increasing DMA masks above what hardware
 supports
In-Reply-To: <57459a4a-2c57-e081-8f27-cb83f23b5815@arm.com>
References: <11daacde-5399-039f-80a3-01d7bd13e9e8@arm.com>
 <1484056844-9567-1-git-send-email-nikita.yoush@cogentembedded.com>
 <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <67314806-361d-e0ac-9292-37542160ead5@cogentembedded.com>
 <57459a4a-2c57-e081-8f27-cb83f23b5815@arm.com>
Message-ID: <09cac197-9e57-5d3e-e742-f29c00051813@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Yes, I think that ought to work, although the __iommu_setup_dma_ops()
> call will still want a real size reflecting the default mask

I see iommu_dma_ops do not define set_dma_mask.

So what if setup was done for size reflecting one mask and then driver
changes mask?  Will things still operate correctly?
