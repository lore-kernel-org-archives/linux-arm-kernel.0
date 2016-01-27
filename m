From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 27 Jan 2016 09:18:44 +0000
Subject: Problem with component helpers and probe deferral in 4.5-rc1
In-Reply-To: <20160126223551.GU10826@n2100.arm.linux.org.uk>
References: <1453831153.2850.107.camel@linaro.org>
 <20160126223551.GU10826@n2100.arm.linux.org.uk>
Message-ID: <1453886324.2847.12.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-01-26 at 22:35 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 26, 2016 at 05:59:13PM +0000, Jon Medhurst (Tixy) wrote:
> > I believe I've found a problem with the component helpers and/or how
> > drivers use them. I discovered this whilst trying to get ARM's HDLCD
> > driver [1] working on 4.5-rc1, however I believe that code is following
> > a pattern used by drivers already in 4.5 and the problem isn't specific
> > to it. This is what I have observed...
> 
> Hmm, it all looks plausible, and I'm again left wondering how the code
> passed testing over the last year (I've been running this code for
> ages both on iMX6 and Dove, where deferred probing does happen.)

It depends on the order of things. To go wrong, components must already
be there before the master is added, then the master needs to defer
probing from it's bind callback. So, components deferring won't trigger
the issue, neither will master deferring before any components have been
added.

> Your patch looks like the right thing to do, so I'll add it to the
> component tree shortly - it should end up in linux-next in a few days
> time.

Thanks. I wasn't sure if that patch was correct as I hadn't looked at
any of this code before this week.

-- 
Tixy
