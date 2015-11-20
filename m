From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 13:12 +0100
Subject: [PATCH, once again] regulator: core: avoid unused variable warning
In-Reply-To: <20151120114127.GS31303@sirena.org.uk>
References: <4219157.sstthfjICN@wuerfel> <20151120114127.GS31303@sirena.org.uk>
Message-ID: <15541673.tdJ35xzzlG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 November 2015 11:41:27 Mark Brown wrote:
> On Fri, Nov 20, 2015 at 12:30:24PM +0100, Arnd Bergmann wrote:
> 
> > The patch that introduced the warning is now in 4.4-rc1, and I think this
> > patch is still the least ugly workaround we found.
> 
> Can we please at least have a comment explaining that this is working
> around lockdep limitations?

Not sure which limitation you are referring to. Maybe you could just
modify the changelog text as you like when applying the patch?

The limitation we talked about in the previous thread was about the maximum
of 8 nesting levels, but my patch here doesn't address that at all.

I tried to capture the fact that mutex_lock_nested() intentionally
doesn't evaluate its second argument when CONFIG_DEBUG_LOCK_ALLOC
is not set, but that appears to be less of a limitation than a
choice of the interface.

	Arnd
