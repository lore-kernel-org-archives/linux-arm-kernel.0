From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2011 08:41:55 +0200
Subject: [PATCH] ARM: CSR: call l2x0_of_init to init L2 cache of
	SiRFprimaII
In-Reply-To: <4E6F9A95.1010109@gmail.com>
References: <1315905006-21390-1-git-send-email-Baohua.Song@csr.com>
	<201109131835.14230.arnd@arndb.de> <4E6F9A95.1010109@gmail.com>
Message-ID: <1801575.1vs7ltBYlO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 September 2011 13:01:57 Rob Herring wrote:
> On 09/13/2011 11:35 AM, Arnd Bergmann wrote:
> > On Tuesday 13 September 2011, Rob Herring wrote:
> >> I have it in init_irq as I need the outer flush to work for SMP init.
> >> init_machine may be okay as well, but as early as possible is probably
> >> best. It depends if you are turning on the L2 or it is already on when
> >> you boot.
> >>
> >> You could also just check your machine compatible string in this
> >> function, but calling it from a machine specific function is a cleaner
> >> solution.
> > 
> > I would suggest checking the specific "compatible" string of the l2x0
> > device node, and making sure that you have something specific to
> > prima2 in it.
> > 
> > That would easily let us combine this function with the respective
> > l2x0 init code for other dt based platforms later, by checking
> > multiple compatible values.
> > 
> The function does that, but you have a problem when multiple platforms
> have a "arm,pl310-cache" string. Or are you saying we need to have
> "csr,prima2-pl310-cache" and strings for every platform out there with a
> pl310?

That was my suggestion, yes. At least for every platform that needs any
sort of nonstandard setup for l2 cache.

In the end it's a question of how you look at it: Do you set up the pl310
differently on one platform from another because you say it's a different
pl310 when it has different requirements, or do you say that all pl310 are
identical and there is a system-wide policy that requires you to set it
up in a specific way?

	Arnd
