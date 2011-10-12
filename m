From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 12 Oct 2011 11:00:10 -0400 (EDT)
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel
	Summit 2011
In-Reply-To: <20111012100109.GB13134@arm.com>
References: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
	<20111012100109.GB13134@arm.com>
Message-ID: <alpine.LFD.2.02.1110121052360.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Oct 2011, Catalin Marinas wrote:

> Hi Grant,
> 
> On Tue, Aug 30, 2011 at 07:00:16AM +0100, Grant Likely wrote:
> > Agenda proposals (Thanks to Nicolas and Olof):
> > - DT bindings for GPIO and pin mux
> > - the pin mux subsystem from linusw (especially if it is still RFC by
> >  then)
> > - progress with the single zImage work
> > - presentation/status of the DMA and memory management work wrt CMA
> >  (some SOC specific hacks should go away once this is available)
> > - DT porting progress
> > - boot architecture status
> > - Report from Arnd on experiences from first arm-soc merge window
> >   - what worked well and where's room for improvement?
> >   - Any particular SoC workflow that should be tuned to make his life easier?
> >   - Where are the gaps where he needs help right now?
> >   - How did it work out for the SoC maintainers?
> 
> Some more thoughts, probably under some of the above topics like single
> zImage or boot architecture if there is time on the agenda:
> 
> - Errata (CPU, cache controller etc.) workarounds - do we need some
>   common way to register workarounds that individual SoCs need to be
>   enabled during boot? With a single zImage platform, we need to enable
>   as many (CPU) errata workarounds as possible but, even though we check
>   the CPU revision, we may find that some undocumented bits cannot be
>   set because Linux is running in non-secure mode (and the secure code
>   on the SoC doesn't set the bit either) or the SoC already implemented
>   an ECO fix and the workaround is no longer needed.

Yes, that would be good to cover during single zImage discussions.

> - CPU topology - Vincent Guittot proposed patches to automatically
>   generate a CPU topology based on the MPIDR. I think we should be able
>   to override this using some DT description (and also be able to
>   describe the mapping between GIC CPU interfaces and the CPU numbering
>   via DT).

I think some discussion around DT bindings is planned.  That would fit 
there.

> Unrelated to the above
> 
> - Different DMA coherency requirements within the same SoC - this is
>   linked to the work already started by Marek on dma_map_ops (though the
>   focus was mainly IOMMU). Basically there are SoCs where some device
>   requires non-cacheable memory while another device is connected via a
>   coherency port and can snoop the CPU caches. The arch_is_coherent()
>   that we currently have is not fine-grained enough for this task.

If you have actual example use cases and solution proposals then this 
could certainly be brought up during DMA oriented discussions.


Nicolas
