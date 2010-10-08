From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 8 Oct 2010 22:08:25 +0200
Subject: 2.6.35.6 fails to suspend (pxa2xx-mci.0)
In-Reply-To: <1286526197.4493.19.camel@sven>
References: <1286177435.2140.5.camel@sven> <201010072323.05218.rjw@sisk.pl>
	<1286526197.4493.19.camel@sven>
Message-ID: <201010082208.25767.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 08, 2010, Sven Neumann wrote:
> On Thu, 2010-10-07 at 23:23 +0200, Rafael J. Wysocki wrote:
> 
> > > > I wonder what happens if you echo 0 to /sys/power/pm_async ?
> > > 
> > > Nothing happens. The problem persists (tested with 2.6.36-rc7). What
> > > would you expect to happen?
> > 
> > Exactly that. :-)
> > 
> > Commit 152e1d5920 should not affect the non-async case (I'd be surprised if
> > it did really) and things should work with /sys/power/pm_async = 0 anyway.
> > 
> > Please try check if you can reproduce with commt 152e1d5920 reverted and
> > /sys/power/pm_async = 0.  If you can, that's a driver bug.
> 
> Ok, for the record, here's what I tried. I have rebooted between tests
> to make sure there's no state pulled in from the previous test:
> 
>  2.6.36-rc7, no changes,      pm_async 1 :  suspend fails
>  2.6.36-rc7, no changes,      pm_async 0 :  suspend fails
> 
>  2.6.36-rc7, 152e1d reverted, pm_async 1 :  suspend works
>  2.6.36-rc7, 152e1d reverted, pm_async 0 :  suspend fails
> 
>  2.6.34.7, no changes,        pm_async 1 :  suspend works
>  2.6.34.7, no changes,        pm_async 0 :  suspend works
> 
> I am not sure how this should be interpreted.

There is a problem with the pxa2xx-mci.0 suspend that has been introduced
some time after 2.6.34, but it is not related to commit 152e1d5920.  The
problem was not visible with pm_async=1 because of the very bug fixed by
commit 152e1d5920.

Please see if the problem is there in 2.6.35 (please test with pm_async=0).

Thanks,
Rafael
