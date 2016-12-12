From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 12 Dec 2016 10:03:21 +0100
Subject: [PATCH] clk: bcm: Fix 'maybe-uninitialized' warning in
 bcm2835_clock_choose_div_and_prate()
In-Reply-To: <2237053.NkkLiYIyzc@wuerfel>
References: <1481529653-28133-1-git-send-email-boris.brezillon@free-electrons.com>
 <3107859.uaKLk6DMRd@wuerfel> <20161212093130.6e348a61@bbrezillon>
 <2237053.NkkLiYIyzc@wuerfel>
Message-ID: <20161212100321.0b0e7172@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Dec 2016 09:34:28 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday, December 12, 2016 9:31:30 AM CET Boris Brezillon wrote:
> > On Mon, 12 Dec 2016 09:12:36 +0100
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >   
> > > On Monday, December 12, 2016 9:00:53 AM CET Boris Brezillon wrote:  
> > > > best_rate is reported as potentially uninitialized by gcc.
> > > > 
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Fixes: 155e8b3b0ee3 ("clk: bcm: Support rate change propagation on bcm2835 clocks")
> > > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>    
> > > 
> > > I wonder why I didn't get that. Which compiler version did you use?
> > >   
> > 
> > In case you're interested, my gcc [1] failed to detect it as well, and
> > this is not the first time it happens :-/.
> > 
> > [1]gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609  
> 
> No, I see it now with gcc-7, it only just turned up in linux-next.
> 
> I ran into it right away with an allmodconfig build. You were
> probably testing based on an earlier v4.9-rc release that had
> the warning globally disabled.

Indeed, I was testing on a 4.9-rc.
