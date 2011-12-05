From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Dec 2011 12:40:16 -0500 (EST)
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <20111205161157.GA27550@localhost.localdomain>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
Message-ID: <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Dec 2011, Dave Martin wrote:
> On Sat, Dec 03, 2011 at 10:12:53AM +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2011-12-02 at 11:28 -0800, Linus Torvalds wrote:
> > > Don't *change* NO_IRQ to zero (that whole #define is broken - leave it
> > > around as a marker of brokenness), just start removing it from all the
> > > ARM drivers that use the OF infrastructure. Which is presumably not
> > > all that many yet.
> > > 
> > > So whenever you find breakage, the fix now is to just remove NO_IRQ
> > > tests, and replace them with "!irq".
> > 
> 
> Russell, do you know whether it would make sense to set a timeline for 
> removing NO_IRQ from ARM platforms and migrating to 0 for the no-interrupt
> case?  I'm assuming that this mainly involves migrating existing hard-wired
> code that deals with interrupt numbers to use irq domains.

How many drivers do use IRQ #0 to start with?  We might discover that in 
practice there is only a very few cases where this is an issue if 0 
would mean no IRQ.


Nicolas
