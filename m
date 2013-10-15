From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 15 Oct 2013 16:46:55 +0100
Subject: [PATCH v8 02/17] arm64: define DMA_ERROR_CODE
In-Reply-To: <20131010094439.GE3817@mudshark.cambridge.arm.com>
References: <alpine.DEB.2.02.1310092109190.26077@kaball.uk.xensource.com>
 <1381351710-1876-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <20131010094439.GE3817@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1310151646430.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Oct 2013, Will Deacon wrote:
> On Wed, Oct 09, 2013 at 09:48:15PM +0100, Stefano Stabellini wrote:
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > CC: will.deacon at arm.com
> > ---
> >  arch/arm64/include/asm/dma-mapping.h |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> > index 8d18100..c2cb8a0 100644
> > --- a/arch/arm64/include/asm/dma-mapping.h
> > +++ b/arch/arm64/include/asm/dma-mapping.h
> > @@ -25,6 +25,7 @@
> >  
> >  #define ARCH_HAS_DMA_GET_REQUIRED_MASK
> >  
> > +#define DMA_ERROR_CODE	(~0)
> 
> Hmm, is this guaranteed to be large enough for a dma_addr_t? Other 64-bit
> architectures using a non-zero error code cast to dma_addr_t before the
> negation.

Good catch! I'll fix it.
