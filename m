From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jun 2011 09:03:12 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous
	=?iso-8859-1?q?Memory=09Allocator?= added
In-Reply-To: <4DF952CC.4010301@balister.org>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106150937.18524.arnd@arndb.de> <4DF952CC.4010301@balister.org>
Message-ID: <201106160903.13135.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 June 2011 02:48:12 Philip Balister wrote:
> On 06/15/2011 12:37 AM, Arnd Bergmann wrote:
> > On Wednesday 15 June 2011 09:11:39 Marek Szyprowski wrote:
> >> I see your concerns, but I really wonder how to determine the properties
> >> of the global/default cma pool. You definitely don't want to give all
> >> available memory o CMA, because it will have negative impact on kernel
> >> operation (kernel really needs to allocate unmovable pages from time to
> >> time).
> >
> > Exactly. This is a hard problem, so I would prefer to see a solution for
> > coming up with reasonable defaults.
> 
> Is this a situation where passing the information from device tree might 
> help? I know this does not help short term, but I am trying to 
> understand the sorts of problems device tree can help solve.

The device tree is a good place to describe any hardware properties such
as 'this device will need 32 MB of contiguous allocations on the memory
bank described in that other device node'.

It is however not a good place to describe user settings such as 'I want
to give this device a 200 MB pool for large allocations so I can run
application X efficiently', because that would require knowledge in the
boot loader about local policy, which it should generally not care about.

	Arnd
