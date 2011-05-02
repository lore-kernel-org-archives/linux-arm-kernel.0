From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 May 2011 13:26:09 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <8yapqo1ogrk.fsf@huya.qualcomm.com>
References: <201104212129.17013.arnd@arndb.de>
	<20110429221554.GD14871@n2100.arm.linux.org.uk>
	<8yapqo1ogrk.fsf@huya.qualcomm.com>
Message-ID: <201105021326.09725.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 May 2011, David Brown wrote:
> I'll confirm this from the Qualcomm side as well.  You cannot have
> multiple inconsistent mappings of the same page without having difficult
> to find problems.

I believe Catalin was referring to the case where you have only
one nonconsistent (cacheable) mapping plus multiple consistent
(cacheable) mappings. I don't think anyone has suggested doing
DMA to a page that has multiple nonconsistent mappings with
virtually indexed caches.

> The spec clarifications appear to give ways of dealing with it if it
> happens, and bounds on what can go wrong, but I wouldn't call it
> something we want to do normally.  Corrupt data is arguably less of a
> problem than nasal demons, but still a problem.

Anything that has a theoretical chance of corrupting data is not an
option, but I'd really like to see what the clarified spec says
about this. Even if there is a way to legally leave a page for
dma_alloc_coherent in the linear mapping, it might turn out to
be harder to do than using highmem pages or unmapping supersections
at run time as was suggested.

	Arnd
