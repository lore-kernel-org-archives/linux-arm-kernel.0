From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 19 Dec 2011 05:03:45 +0100
Subject: [PATCH] MXS: Convert mutexes in clock.c to spinlocks
In-Reply-To: <20111219032712.GB4962@S2100-06.ap.freescale.net>
References: <1324217174-6574-1-git-send-email-marek.vasut@gmail.com>
 <20111219032712.GB4962@S2100-06.ap.freescale.net>
Message-ID: <201112190503.46668.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sun, Dec 18, 2011 at 03:06:13PM +0100, Marek Vasut wrote:
> > The mutexes can't be safely used under certain circumstances. I noticed
> > this
> 
> > issue during some network instability at home:
> Yes, this is a known issue.  And there was some discussion[1] about
> why mutex is needed.

Thanks for pointing this out, I was unaware of it.

> But I really have not thought about why we can
> not use spinlock only, since using mutex only leads to the issue we
> are seeing here, and using spinlock in enable/disable and mutex in
> rate/parent will not work, because the mxs clocks have enable/disable
> and rate/parent functions access the same register.  I know it's not
> good to hold spinlock in rate/parent functions for a long time, but
> do we have a way around rather than using spinlock for both sets of
> functions?

Yea, spinlock is not good either. On the other hand, is it really held for so 
long ?

M
