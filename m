From: oliver@neukum.org (Oliver Neukum)
Date: Sat, 6 Mar 2010 12:05:17 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201003061156.41136.wolfgang@iksw-muees.de>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<20100304093117.GA5282@n2100.arm.linux.org.uk>
	<201003061156.41136.wolfgang@iksw-muees.de>
Message-ID: <201003061205.17490.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 6. M?rz 2010 11:56:41 schrieb Wolfgang M?es:
> > 1. A page is faulted in for an application, and it is a text page.
> >    - the data read in to the page needs to be visible to the instruction
> >      stream, so on Harvard architecture machines, this may require cache
> >      maintainence on both the D and I caches.
> Yes. I think that the EXPECTED behaviour of block devices is to give the 
> result of the read back in memory. So the driver should do the flush of the 
> data cache.
> 
> The invalidation of the I cache should be done by the function which makes 
> this piece of data executable. (Have I missed something here?)

What tells you that IO is happening before the page is made executable?

	Regards
		Oliver
