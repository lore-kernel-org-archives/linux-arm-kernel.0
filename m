From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jun 2011 20:30:07 +0200
Subject: [PATCH 08/10] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <op.vw2r3xrj3l0zgt@mnazarewicz-glaptop>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106141803.00876.arnd@arndb.de>
	<op.vw2r3xrj3l0zgt@mnazarewicz-glaptop>
Message-ID: <201106142030.07549.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 June 2011 18:58:35 Michal Nazarewicz wrote:
> On Tue, 14 Jun 2011 18:03:00 +0200, Arnd Bergmann wrote:
> > For all I know, that is something that is only true for a few very  
> > special Samsung devices,
> 
> Maybe.  I'm just answering your question. :)
> 
> Ah yes, I forgot that separate regions for different purposes could
> decrease fragmentation.

That is indeed a good point, but having a good allocator algorithm
could also solve this. I don't know too much about these allocation
algorithms, but there are probably multiple working approaches to this.

> > I would suggest going forward without having multiple regions:
> 
> Is having support for multiple regions a bad thing?  Frankly,
> removing this support will change code from reading context passed
> as argument to code reading context from global variable.  Nothing
> is gained; functionality is lost.

What is bad IMHO is making them the default, which forces the board
code to care about memory management details. I would much prefer
to have contiguous allocation parameters tuned automatically to just
work on most boards before we add ways to do board-specific hacks.

	Arnd
