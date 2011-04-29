From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Apr 2011 17:41:17 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <1303902508.15101.21.camel@e102109-lin.cambridge.arm.com>
References: <201104212129.17013.arnd@arndb.de>
	<201104271243.16868.arnd@arndb.de>
	<1303902508.15101.21.camel@e102109-lin.cambridge.arm.com>
Message-ID: <201104291741.18190.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2011, Catalin Marinas wrote:
> > >
> > > It's not broken since we moved to using Normal non-cacheable memory
> > > for the coherent DMA buffers (as long as you flush the cacheable alias
> > > before using the buffer, as we already do). The ARM ARM currently says
> > > unpredictable for such situations but this is being clarified in
> > > future updates and the Normal non-cacheable vs cacheable aliases can
> > > be used (given correct cache maintenance before using the buffer).
> > 
> > Thanks for that information, I believe a number of people in the
> > previous discussions were relying on the information from the
> > documentation. Are you sure that this is not only correct for the
> > cores made by ARM ltd but also for the other implementations that
> > may have relied on documentation?
> 
> It is a clarification in the ARM ARM so it covers all the cores made by
> architecture licensees, not just ARM Ltd. It basically makes the
> "unpredictable" part more predictable to allow certain types of aliases
> (e.g. Strongly Ordered vs Normal memory would still be disallowed).
> 
> All the current implementations are safe with Normal memory aliases
> (cacheable vs non-cacheable) but of course, there may be some
> performance benefits in not having any alias.

A lot of the discussions we are about to have in Budapest will be
around solving the problem of having only valid combinations of
mappings, so we really need to have a clear statement in specification
form about what is actually valid.

Would it be possible to have an updated version of the relevant
section of the ARM ARM by next week so we can use that as the
base for our discussions?

	Arnd
