From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 15 Jul 2010 22:46:16 -0400 (EDT)
Subject: Question of kmap_atomic
In-Reply-To: <AANLkTimy4fLzkAmVpxB9sTBUMQsqwMXjFLRUmk1dNEvm@mail.gmail.com>
References: <AANLkTilFvE0eyQS7jNQ77OYkJovJugjKRO-fPHjX8CB9@mail.gmail.com>
	<alpine.LFD.2.00.1007152200520.10598@xanadu.home>
	<AANLkTimy4fLzkAmVpxB9sTBUMQsqwMXjFLRUmk1dNEvm@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1007152241110.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Jul 2010, Minchan Kim wrote:

> >> But the patch made it to not call kmap_high_get when VIPT-aliasing
> >> model in CONFIG_DEBUG_HIGHMEM.
> >> Doesn't it cause aliasing problem as 7929eb9cf64 says, again?
> >
> > No because with VIPT, the cache is tagged with physical addresses, and
> > therefore the same cache data will be used for the same memory
> > regardless of the virtual address used to reach it. ?On VIVT this is not
> > the case and the comment in 7929eb9cf64 applies to VIVT only.
> 
> Thanks for quick reply, Nicolas.
> 
> My concern is following as.
> 
> In VIPT alising model,
[...]

Highmem is not supported with VIPT alising and probably will never be. 
See commit 3f973e22.


Nicolas
