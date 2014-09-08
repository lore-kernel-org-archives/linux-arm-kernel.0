From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 22:36:45 +0200
Subject: [PATCH] ARM: avoid l2x0 build warning for CONFIG_OF=n
In-Reply-To: <20140908153946.GB12361@n2100.arm.linux.org.uk>
References: <2852268.nkG1OoBDfE@wuerfel>
 <20140908153946.GB12361@n2100.arm.linux.org.uk>
Message-ID: <2958731.nsOomQFma0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 16:39:46 Russell King - ARM Linux wrote:
> On Mon, Sep 08, 2014 at 04:53:39PM +0200, Arnd Bergmann wrote:
> > A few functions in the l2x0 code are now only used from code that
> > is DT-only, so we get harmless gcc warnings about unused static
> > symbols unless these are removed as well.
> > 
> > arch/arm/mm/cache-l2x0.c:167:13: warning: 'l2x0_cache_sync' defined but not used [-Wunused-function]
> > arch/arm/mm/cache-l2x0.c:184:13: warning: 'l2x0_flush_all' defined but not used [-Wunused-function]
> > arch/arm/mm/cache-l2x0.c:194:13: warning: 'l2x0_disable' defined but not used [-Wunused-function]
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: cf9ea8f130e2 ("ARM: l2c: remove obsolete l2x0 ops for non-OF init")
> 
> I've already NAK'd patches like this.  This needs solving properly.
> 
> Never hide valid warnings like this.

Ok, it wasn't clear to me that these were intentionally left in there. I've
spent a little more time looking at this code and managed to come up with
two different patches to clean this code up. I don't know if this is what you
had in mind, but it does feel like a noticeable improvement, so if I missed
the real point, they could at least be used as a starting point for the next
person to look at this.

I've put the Free-electrons and Marvell folks that are involved with the
aurora code on Cc, so I hope one of them can give try this out on real
hardware or inspect the code further.

	Arnd
