From: Poonam.Aggrwal@freescale.com (Aggrwal Poonam)
Date: Tue, 8 Sep 2015 04:31:46 +0000
Subject: arm_coherent_dma_alloc
In-Reply-To: <20150904132604.GD17253@e104818-lin.cambridge.arm.com>
References: <DM2PR0301MB070161BE05943337F62EA5218C680@DM2PR0301MB0701.namprd03.prod.outlook.com>
 <20150904132604.GD17253@e104818-lin.cambridge.arm.com>
Message-ID: <DM2PR0301MB0701C97092AB154986A70EC18C530@DM2PR0301MB0701.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Friday, September 04, 2015 6:56 PM
> To: Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: arm_coherent_dma_alloc
> 
> On Thu, Sep 03, 2015 at 04:50:56AM +0000, Aggrwal Poonam wrote:
> > I am looking at the ?file: "arch/arm/mm/dma-mapping.c"
> >
> > static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
> > ??????? dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs) {
> > ? ??????pgprot_t prot = __get_dma_pgprot(attrs, pgprot_kernel);
> > ??????? void *memory;
> >
> > ??????? if (dma_alloc_from_coherent(dev, size, handle, &memory))
> > ??????????????? return memory;
> >
> > ??????? return __dma_alloc(dev, size, handle, gfp, prot, true,
> > ?????????? ????????????????__builtin_return_address(0)); }
> >
> > I want to understand the attributes of ?memory allocated using
> > __dma_alloc, in terms of cacheable.
> 
> If is_coherent == true (for __dma_alloc), the attributes are Normal
> Cacheable (the case above).
Thanks !.
In this case; what are the values of  TEX[2:0], C, B bits?

Regards
Poonam
> 
> If __dma_alloc() is called with is_coherent == false, the attributes are given
> by __get_dma_pgprot() and they would be Normal Non-cacheable.
> 

> --
> Catalin
