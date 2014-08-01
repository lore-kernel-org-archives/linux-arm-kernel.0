From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 1 Aug 2014 22:43:06 +0530
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140731162330.GE3952@lukather>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <20140731115628.GQ8181@intel.com> <20140731162330.GE3952@lukather>
Message-ID: <20140801171306.GF8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 06:23:30PM +0200, Maxime Ripard wrote:
> On Thu, Jul 31, 2014 at 05:26:28PM +0530, Vinod Koul wrote:
> 
> Also, feel free to add anything that you feel like you keep saying
> during the review. If mistakes keep coming, it's probably worth
> documenting what you expect.
I think the common issues seen would be:
- prpeare calls in atomic context and usuage of GFP_NOWAIT for memory
  allocations
- residue callculation, though situation is much better now but still lots
  of driver do it worng and folks do get it wrong

> 
> > > Because, for the moment, we're pretty much left in the dark with
> > > different drivers doing the same thing in completetely different ways,
> > > with basically no way to tell if it's either the framework that
> > > requires such behaviour, or if the author was just feeling creative.
> > > 
> > > There's numerous examples for this at the moment:
> > >   - The GFP flags, with different drivers using either GFP_ATOMIC,
> > >     GFP_NOWAIT or GFP_KERNEL in the same functions
> > >   - Having to set device_slave_caps or not?
> > >   - Some drivers use dma_run_depedencies, some other don't
> > >   - That might just be my experience, but judging from previous
> > >     commits, DMA_PRIVATE is completely obscure, and we just set it
> > >     because it was making it work, without knowing what it was
> > >     supposed to do.
> > >   - etc.
> > 
> > Thanks for highlighting we should definitely add these in Documentation
> 
> It's quite clear in the case of the GFP flags now, Lars-Peter and you
> cleared up device_slave_caps, but I still could use some help with
> DMA_PRIVATE.
> 
> > > And basically, we have no way to tell at the moment which one is
> > > right and which one needs fixing.
> > > 
> > > The corollary being that it cripples the whole community ability to
> > > maintain the framework and make it evolve.
> > > 
> > > > > +  * device_slave_caps
> > > > > +    - Isn't that redundant with the cap_mask already?
> > > > > +    - Only a few drivers seem to implement it
> > > > For audio to know what your channel can do rather than hardcoding it
> > > 
> > > Ah, yes, I see it now. It's not related to the caps mask at all.
> > > 
> > > Just out of curiosity, wouldn't it be better to move this to the
> > > framework, and have these informations provided through the struct
> > > dma_device? Or would it have some non-trivial side-effects?
> > Well the problem is ability to have this queried uniformly from all drivers
> > across subsystems. If we can do this that would be nice.
> 
> I can work on some premelinary work to do just that, and see if it
> works for you then.
Sure sounds excellent to me

-- 
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140801/5dd068cc/attachment.sig>
