From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2011 14:45:09 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <20110616170133.GC28032@labbmf-linux.qualcomm.com>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106160006.07742.arnd@arndb.de>
	<20110616170133.GC28032@labbmf-linux.qualcomm.com>
Message-ID: <201106171445.09567.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 June 2011 19:01:33 Larry Bassel wrote:
> > Can you describe how the memory areas differ specifically?
> > Is there one that is always faster but very small, or are there
> > just specific circumstances under which some memory is faster than
> > another?
> 
> One is always faster, but very small (generally 2-10% the size
> of "normal" memory).
> 

Ok, that sounds like the "SRAM" regions that we are handling on some
ARM platforms using the various interfaces. It should probably
remain outside of the regular allocator, but we can try to generalize
the SRAM support further. There are many possible uses for it.

	Arnd
