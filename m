From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 13:28:02 +0100
Subject: [PATCH, once again] regulator: core: avoid unused variable warning
In-Reply-To: <20151120122400.GA1929@sirena.org.uk>
References: <4219157.sstthfjICN@wuerfel> <15541673.tdJ35xzzlG@wuerfel>
 <20151120122400.GA1929@sirena.org.uk>
Message-ID: <4611580.31jynMWjmL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 November 2015 12:24:00 Mark Brown wrote:
> On Fri, Nov 20, 2015 at 01:12:00PM +0100, Arnd Bergmann wrote:
> > On Friday 20 November 2015 11:41:27 Mark Brown wrote:
> 
> > > Can we please at least have a comment explaining that this is working
> > > around lockdep limitations?
> 
> > Not sure which limitation you are referring to. Maybe you could just
> > modify the changelog text as you like when applying the patch?
> 
> > I tried to capture the fact that mutex_lock_nested() intentionally
> > doesn't evaluate its second argument when CONFIG_DEBUG_LOCK_ALLOC
> > is not set, but that appears to be less of a limitation than a
> > choice of the interface.
> 
> That's the limitation (or intereface choice or whatever) that I'm
> talking about - the code looks like a function call so not evaulating
> the second argument is surprising.  I'm looking for something in the
> code rather than the changelog so it doesn't get cleaned up later.
> 

Got it. Will send a new version soon.

	Arnd
