From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 03 Jan 2012 09:12:42 -0500 (EST)
Subject: Git pull request: shmobile fix for the vmalloc series
In-Reply-To: <20120103095958.GJ2914@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1201022323090.2907@xanadu.home>
 <20120103095958.GJ2914@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1201030905530.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jan 2012, Russell King - ARM Linux wrote:

> On Mon, Jan 02, 2012 at 11:34:21PM -0500, Nicolas Pitre wrote:
> > Russell, please pull the following into your devel-stable branch:
> > 
> > 	git://git.linaro.org/people/nico/linux vmalloc
> > 
> > This contains a patch from Magnus Damm fixing the oversized DMA area 
> > issue on shmobile, and a revert of the temporary and noisy workaround 
> > (which is already in your devel-stable branch) that was needed because 
> > of that issue.
> 
> Is there much point?  shmobile shows no sign of fixing their #error for
> the restart changes (and haven't responded to any of my emails)

Well, it took them 3 months before they responded to mine with a patch.  
So it would be fair to merge the fix for this one issue, even if it is 
only to remove the ugly VMALLOC_END hack from pgtable.h.

> I think we should be thinking about removing this -clearly- 
> unmaintained set of platforms.
> 
> So, it currently looks like I'm going to be pushing a #error for them
> in during the next merge window.  I'd much rather just delete the
> unmaintained code to avoid adding those evil things.

I'd vote for the #error.  My noisy #warning is possibly what created 
some motion here.


Nicolas
