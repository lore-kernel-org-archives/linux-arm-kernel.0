From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 20 Jun 2017 06:24:00 -0700
Subject: [PATCH v5 1/7] dma: Take into account dma_pfn_offset
In-Reply-To: <1495621472-9323-2-git-send-email-vladimir.murzin@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170620132400.GB11370@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -		sg_dma_address(sg) = (dma_addr_t)virt_to_phys(va);
> +		sg_dma_address(sg) = (dma_addr_t)(virt_to_phys(va) - PFN_PHYS(dev->dma_pfn_offset));

Needs a line break instead of the overly long line.

Otherwise this looks fine to me.
