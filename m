From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 13 Oct 2014 12:16:14 +0100
Subject: [PATCH v4 3/7] [RFC] arm/arm64: introduce is_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1410101401250.17038@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410101244090.17038@kaball.uk.xensource.com>
 <1412941908-5850-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <20141010120702.GI7755@arm.com>
 <alpine.DEB.2.02.1410101401250.17038@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1410131215400.17038@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Oct 2014, Stefano Stabellini wrote:
> On Fri, 10 Oct 2014, Will Deacon wrote:
> > On Fri, Oct 10, 2014 at 12:51:44PM +0100, Stefano Stabellini wrote:
> > > Introduce a function to check whether a device is dma coherent.
> > > 
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > CC: linux at arm.linux.org.uk
> > > CC: catalin.marinas at arm.com
> > > CC: will.deacon at arm.com
> > > CC: linux-arm-kernel at lists.infradead.org
> > > ---
> > >  arch/arm/include/asm/dma-mapping.h   |    6 ++++++
> > >  arch/arm64/include/asm/dma-mapping.h |    5 +++++
> > >  2 files changed, 11 insertions(+)
> > > 
> > > diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> > > index c45b61a..bededbb 100644
> > > --- a/arch/arm/include/asm/dma-mapping.h
> > > +++ b/arch/arm/include/asm/dma-mapping.h
> > > @@ -126,6 +126,12 @@ static inline int set_arch_dma_coherent_ops(struct device *dev)
> > >  	set_dma_ops(dev, &arm_coherent_dma_ops);
> > >  	return 0;
> > >  }
> > > +
> > > +static inline bool is_dma_coherent(struct device *dev)
> > > +{
> > > +    return (__generic_dma_ops(dev) == &arm_coherent_dma_ops);
> > > +}
> > 
> > Hmm, what about the IOMMU ops?
> 
> Maybe I should check __generic_dma_ops(dev) != &arm_dma_ops?
> Do you have any better suggestions?

ping?
