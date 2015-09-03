From: Poonam.Aggrwal@freescale.com (Aggrwal Poonam)
Date: Thu, 3 Sep 2015 04:50:56 +0000
Subject: arm_coherent_dma_alloc
Message-ID: <DM2PR0301MB070161BE05943337F62EA5218C680@DM2PR0301MB0701.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello


I am looking at the ?file: "arch/arm/mm/dma-mapping.c"

static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
??????? dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
{
? ??????pgprot_t prot = __get_dma_pgprot(attrs, pgprot_kernel);
??????? void *memory;

??????? if (dma_alloc_from_coherent(dev, size, handle, &memory))
??????????????? return memory;

??????? return __dma_alloc(dev, size, handle, gfp, prot, true,
?????????? ????????????????__builtin_return_address(0));
}

I want to understand the attributes of ?memory allocated using __dma_alloc, in terms of cacheable.

This specific question is for CortexA7 MP core.

Regards
Poonam
