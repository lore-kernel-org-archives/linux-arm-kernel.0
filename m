From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 12 Dec 2016 19:22:52 +1100
Subject: [PATCH] clk: bcm: Fix 'maybe-uninitialized' warning in
 bcm2835_clock_choose_div_and_prate()
In-Reply-To: <3107859.uaKLk6DMRd@wuerfel>
References: <1481529653-28133-1-git-send-email-boris.brezillon@free-electrons.com>
 <3107859.uaKLk6DMRd@wuerfel>
Message-ID: <20161212192252.56e6ac99@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, 12 Dec 2016 09:12:36 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Monday, December 12, 2016 9:00:53 AM CET Boris Brezillon wrote:
> > best_rate is reported as potentially uninitialized by gcc.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Fixes: 155e8b3b0ee3 ("clk: bcm: Support rate change propagation on bcm2835 clocks")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>  
> 
> I wonder why I didn't get that. Which compiler version did you use?

Gcc-5.2.0 powerpc-le hosted cross compiler.

-- 
Cheers,
Stephen Rothwell
