From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 20 Apr 2016 18:41:46 +0530
Subject: [PATCH V2 2/3] dmaengine: bcm2835: use platform_get_irq_byname
In-Reply-To: <CAMuHMdUgfyLrdmfHLHd3eNh79FcJarVPuhbxtU4XYZok=skLkw@mail.gmail.com>
References: <1460381349-14408-1-git-send-email-kernel@martin.sperl.org>
 <1460381349-14408-3-git-send-email-kernel@martin.sperl.org>
 <CAMuHMdW2Jw5=f9ojNSM0d1cGvPc6_QxwH4rcQdWBQTP89zyj4Q@mail.gmail.com>
 <571762A7.7000005@martin.sperl.org>
 <CAMuHMdUgfyLrdmfHLHd3eNh79FcJarVPuhbxtU4XYZok=skLkw@mail.gmail.com>
Message-ID: <20160420131146.GA2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 01:12:36PM +0200, Geert Uytterhoeven wrote:
> Hi Martin,
> 
> On Wed, Apr 20, 2016 at 1:06 PM, Martin Sperl <kernel@martin.sperl.org> wrote:
> > On 20.04.2016 08:51, Geert Uytterhoeven wrote:
> >>
> >> On Mon, Apr 11, 2016 at 3:29 PM,  <kernel@martin.sperl.org> wrote:
> >>>
> >>> From: Martin Sperl <kernel@martin.sperl.org>
> >>>
> >>> Use platform_get_irq_byname to allow for correct mapping of
> >>> interrupts to dma channels.
> >>>
> >>> The currently implemented device tree is unfortunately
> >>> implemented with the wrong assumption, that each dma-channel
> >>> has its own dma channel, but dma-irq 11 is handling
> >>> dma-channel 11-14 and dma-irq 12 is actually a "catch all"
> >>> interrupt.
> >>>
> >>> So here we use the byname variant and require that interrupts
> >>> are explicitly named via the interrupts-name property in the
> >>
> >> interrupt-names

well spotted

> >
> > Vinod has just merged this patch - do you want me to submit another
> 
> Yeah, that's how I noticed by accident :-)
> 
> > to correct those?
> 
> For the commit message it's indeed too late. For the error message in the
> code, yes please.

I can drop the branch

-- 
~Vinod
