From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Apr 2011 22:39:57 +0200
Subject: [PATCH 1/2] ux500: Adding support for u8500 Hsem functionality V2
In-Reply-To: <4DA4A44D.5020208@linaro.org>
References: <1302535464-12294-1-git-send-email-mathieu.poirier@linaro.org>
	<201104121946.01618.arnd@arndb.de> <4DA4A44D.5020208@linaro.org>
Message-ID: <201104172239.57362.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 April 2011, Mathieu Poirier wrote:
> > struct u8500_hsem_state {
> >       void __iomem *io_base;
> >       struct u8500_hsem hsem[U8500_MAX_SEMAPHORE];
> > }
> I don't see the real advantage in doing a single allocation - the 
> dynamic allocation method is also used in 'omap_hwspinlock.c'.  Is 
> modification mandatory to get the driver accepted ?

Not strictly required, but somewhat cleaner IMHO. If you have a good
reason for splitting the allocations, just document that clearly.

One more thing I just noticed: the hwspinlock_internal.h file defines
the hwspinlock->id field as "a global, unique, system-wide, index of
the lock", but the u8500 hsem just sets it to an integer starting
at zero. If there are multiple devices providing hwspinlocks in the
same system, that cannot work.

	Arnd
