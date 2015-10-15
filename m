From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 15 Oct 2015 09:37:08 +0530
Subject: [PATCH v2 2/4] dmaengine: Add STM32 DMA driver
In-Reply-To: <CAOAejn0chZD5mgi8WrW3ow3APUHTJOYP4=G2jCZ_Po4qe9eACw@mail.gmail.com>
References: <1444745127-1105-3-git-send-email-cedric.madianga@gmail.com>
 <561D1689.90703@linaro.org>
 <CAOAejn1N=dFZ3nQ_hNznJQX1-fkP3r=vdYuWY4OMH65PrW3xVg@mail.gmail.com>
 <CAOAejn2pcFSn3Hf=j6zgg6Ui6GjJZrtRch6ywByHaVLsTLMk6A@mail.gmail.com>
 <561E58AC.80207@linaro.org>
 <CAOAejn1XqvZDmCgGr5rmZoz2EzFUyxtmpSm0_atLr81rSJrEcw@mail.gmail.com>
 <561E658D.1070900@linaro.org>
 <CAOAejn1spB+BCRh9+jJtaKxEmaRc04nveF3rQEbT7kLMH0kOkg@mail.gmail.com>
 <561E7497.1050105@linaro.org>
 <CAOAejn0chZD5mgi8WrW3ow3APUHTJOYP4=G2jCZ_Po4qe9eACw@mail.gmail.com>
Message-ID: <20151015040708.GC27370@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 05:41:26PM +0200, M'boumba Cedric Madianga wrote:
> 2015-10-14 17:28 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
> > On 14/10/15 16:26, M'boumba Cedric Madianga wrote:
> >>
> >> 2015-10-14 16:24 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
> >>>
> >>>
> >>> Hmnnn...
> >>>
> >>> The dmaengine framework will WARN_ONCE() if an dmaengine is removed
> >>> whilst
> >>> it is active and also works hard to ensure dmaengine modules are not
> >>> removed
> >>> whilst there are active drivers using the framework.
> >>>
> >>> How do we get into this function whilst there is still an active DMA
> >>> channels?
> >>
> >>
> >> For example, when a user try "rmmod stm32-dma" in uart console.
> >> It will enter in stm32_dma_remove while there is potentially still active
> >> DMA.
> >
> >
> > Check dmaengine.c for yourself but I think in this case the dmaengine
> > framework will hold references to the module and prevent the remove from
> > taking place.
> 
> Yes I did it.
> As far I understand, the dmaengine framework will print a warning
> message but doesn't stop removing operation if there are some active
> clients.

we hold a ref, so removal wont work, see dma_chan_get()

-- 
~Vinod
