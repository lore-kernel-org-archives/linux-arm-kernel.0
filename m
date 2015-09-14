From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Sep 2015 13:32:27 +0200
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <55F6A9DB.8040503@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F6A437.3040403@citrix.com> <55F6A9DB.8040503@citrix.com>
Message-ID: <2415578.qstFX0Ux2G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 September 2015 13:04:59 Roger Pau Monn? wrote:
> > TBH, I'm expecting a small impact to the performance. It would be hard
> > to get the exactly the same performance as today if we keep the helpers
> > to avoid the backend dealing himself with the splitting and page
> > granularity.
> > 
> > Although, if the performance impact is not acceptable, it may be
> > possible to optimize gnttab_foreach_grant_in_range by moving the
> > function inline. The current way to the loop is the fastest I've found
> > (I've wrote a small program to test different way) and we will need it
> > when different of size will be supported.
> 
> I don't expect the performance to drop massively with this patches
> applied, but it would be good to al least have an idea of the impact.

Note that using 64kb pages in Linux tends to destroy performance
in Linux in any case, as the memory consumption for most workloads
explodes. In a virtualized environment you already tend to be
memory constrained, so any measurement should take that into account
and put the extra overhead into perspective to the massive overhead
of running 64kb pages when RAM is tight.

	Arnd
