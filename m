From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 13 Jul 2011 14:18:49 -0700
Subject: [PATCH] new helper to define common struct resource constructs
In-Reply-To: <201107121529.17611.arnd@arndb.de>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107072304.05626.arnd@arndb.de>
	<E1QgHeh-0004k8-2m@octopus.hi.pengutronix.de>
	<201107121529.17611.arnd@arndb.de>
Message-ID: <20110713141849.b8cbf675.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jul 2011 15:29:17 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 11 July 2011, Uwe Kleine-K__nig wrote:
> > resource definitions that just define start, end and flags = IORESOURCE_MEM
> > or IORESOURCE_IRQ (with start=end) are quite common. So introduce a shortcut
> > for them. Also make available a macro to specify named resources of both
> > types which are less common.
> > 
> > Signed-off-by: Uwe Kleine-K____nig <u.kleine-koenig@pengutronix.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> What do others think, is this worthwhile?
> Should we also define macros for IORESOURCE_IO and IORESOURCE_DMA?
> 

It would help if we could see some usage examples (ie: sample
conversions), to get a better idea of the value of this.

Also, DEFINE_RES_NAMED() is going to need a bunch of argument
parentheses to make it bulletproof.
