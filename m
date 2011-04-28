From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 28 Apr 2011 15:46:06 +0900
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104280840.09206.arnd@arndb.de>
References: <20110427073514.GH17290@n2100.arm.linux.org.uk>
	<1303940271.2513.187.camel@pasglop>
	<201104280840.09206.arnd@arndb.de>
Message-ID: <20110428154347Z.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Apr 2011 08:40:08 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 27 April 2011 23:37:51 Benjamin Herrenschmidt wrote:
> > On Wed, 2011-04-27 at 08:35 +0100, Russell King - ARM Linux wrote:
> > > On Thu, Apr 21, 2011 at 09:29:16PM +0200, Arnd Bergmann wrote:
> > > > 2. Implement dma_alloc_noncoherent on ARM. Marek pointed out
> > > >    that this is needed, and it currently is not implemented, with
> > > >    an outdated comment explaining why it used to not be possible
> > > >    to do it.
> > > 
> > > dma_alloc_noncoherent is an entirely pointless API afaics.
> > 
> > I was about to ask what the point is ... (what is the expected
> > semantic ? Memory that is reachable but not necessarily cache
> > coherent ?)
> 
> Drivers use this when they explicitly want to manage the caching
> themselves.

Not "want to manage". The API is for drivers that "have to" manage the
cache because of architectures that can't allocate coherent memory.

> I think this is most interesting on big NUMA systems,
> where you really want to use fast (local cached) memory and
> then flush it explicitly to do dma. Very few drivers use this:
