From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Oct 2015 21:28:13 +0200
Subject: [PATCH] regulator: core: avoid unused variable warning
In-Reply-To: <20151012154231.GE4238@sirena.org.uk>
References: <5130320.kXvB35QoYU@wuerfel> <20151012154231.GE4238@sirena.org.uk>
Message-ID: <6859029.WgxSIWq5Yi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 16:42:31 Mark Brown wrote:
> On Fri, Oct 09, 2015 at 02:36:47PM +0200, Arnd Bergmann wrote:
> 
> > The second argument of the mutex_lock_nested() helper is only
> > evaluated if CONFIG_DEBUG_LOCK_ALLOC is set. Otherwise we
> > get this build warning for the new regulator_lock_supply
> > function:
> 
> Shouldn't we have an annotation or something for this in
> mutex_lock_nested()?  It seems like something that might come up
> elsewhere and it's a bit of a surprise to have one of the arguments
> there not be evaluated.
> 

I've found a better solution by making mutex_lock_nested an
inline function. Will send a new patch.

	Arnd
