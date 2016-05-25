From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 25 May 2016 14:37:13 +0200
Subject: [PATCH 0/4] dma-mapping: Constify dma_attrs
In-Reply-To: <20160524090938.GA13166@infradead.org>
References: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
 <20160524090938.GA13166@infradead.org>
Message-ID: <57459C79.8060204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2016 11:09 AM, Christoph Hellwig wrote:
> I think this is moving into the wrong direction.  The right fix here
> is to get of all the dma_attrs boilerplate code and just replace it
> with a simple enum dma_flags.  This would simplify both the callers
> and most importantly the wrappers for the flag-less versions a lot.

The dma attrs are additive so maybe not an enum but an unsigned long and
#defines:

#define	DMA_ATTR_WRITE_BARRIER		0x0001u
#define DMA_ATTR_WEAK_ORDERING		0x0002u
#define DMA_ATTR_WRITE_COMBINE		0x0004u
...

The intrusiveness of it would be similar but indeed looks simpler - when
reading the code and when setting the dma_attrs.

If that seems reasonable, I will send a follow up with new approach.

Thanks for feedback!

Best regards,
Krzysztof
