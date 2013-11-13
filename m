From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 13 Nov 2013 23:07:19 +0100
Subject: [PATCH 1/2] dmaengine: add msm bam dma driver
In-Reply-To: <20131030203105.GA14525@agross>
References: <1382732643-8184-1-git-send-email-agross@codeaurora.org>
 <20131029175603.GF21983@codeaurora.org> <20131030203105.GA14525@agross>
Message-ID: <3732966.zLLfiChgvH@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Wednesday 30 of October 2013 15:31:05 Andy Gross wrote:
> On Tue, Oct 29, 2013 at 10:56:03AM -0700, Stephen Boyd wrote:
> > On 10/25, Andy Gross wrote:
> > > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > > index f238cfd..a71b415 100644
> > > --- a/drivers/dma/Kconfig
> > > +++ b/drivers/dma/Kconfig
> > > @@ -364,4 +364,13 @@ config DMATEST
> > >  	  Simple DMA test client. Say N unless you're debugging a
> > >  	  DMA Device driver.
> > >  
> > > +
> > > +config MSM_BAM_DMA
> > > +	tristate "MSM BAM DMA support"
> > > +	depends on ARCH_MSM
> > 
> > It would be nice if we didn't have to rely on ARCH_MSM here so we
> > get more build coverage.
>  
> I can remove that.  There is nothing that forces this depend option.

Instead of removing, please add "|| COMPILE_TEST". This is the right way
to allow drivers not supposed to be run on given platform to build on it.

Best regards,
Tomasz
