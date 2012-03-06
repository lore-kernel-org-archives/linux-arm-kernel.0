From: vdumpa@nvidia.com (Krishna Reddy)
Date: Tue, 6 Mar 2012 15:36:32 -0800
Subject: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <20120306232138.GF15201@n2100.arm.linux.org.uk>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
 <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
 <20120306232138.GF15201@n2100.arm.linux.org.uk>
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E3797011437@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, Feb 29, 2012 at 04:04:22PM +0100, Marek Szyprowski wrote:
> > +static int arm_iommu_mmap_attrs(struct device *dev, struct
> vm_area_struct *vma,
> > +		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
> > +		    struct dma_attrs *attrs)
> > +{
> > +	struct arm_vmregion *c;
> > +
> > +	vma->vm_page_prot = __get_dma_pgprot(attrs, vma-
> >vm_page_prot);
> > +	c = arm_vmregion_find(&consistent_head, (unsigned
> long)cpu_addr);
> 
> What protects this against other insertions/removals from the list?

arm_vmregion_find uses a spin_lock internally before accessing consistent_head.
 So, it is protected.


-KR

--nvpublic
