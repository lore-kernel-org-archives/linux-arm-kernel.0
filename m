From: tony@atomide.com (Tony Lindgren)
Date: Thu, 25 Oct 2012 12:34:13 -0700
Subject: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add
 read_reset_sources pdata function pointer
In-Reply-To: <alpine.DEB.2.00.1210251929500.21193@utopia.booyaka.com>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013213.21844.20016.stgit@dusk.lan>
 <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
 <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com>
 <20121025185755.GV11928@atomide.com>
 <alpine.DEB.2.00.1210251908560.21193@utopia.booyaka.com>
 <20121025191936.GZ11928@atomide.com>
 <alpine.DEB.2.00.1210251929500.21193@utopia.booyaka.com>
Message-ID: <20121025193413.GA11928@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121025 12:32]:
> On Thu, 25 Oct 2012, Tony Lindgren wrote:
> 
> > I wonder if we can now with multiple watchdogs supported to
> > have also PRM/CM implement omap_prcm_wdt_ioctl() that just
> > handles WDIOC_GETBOOTSTATUS and then just remove that handling
> > from the other omap watchdog drivers?
> 
> The watchdog ioctl code needs access to internal watchdog state and 
> functions, for example  WDIOC_KEEPALIVE and  WDIOC_SETTIMEOUT.  How would 
> the approach you're thinking of implement those operations?

I have not looked how the watchdog subsystem handles multiple
watchdogs, but.. Can't we have the omap watchdog and twl watchdog
return -ENOTSUPP for WDIOC_GETBOOTSTATUS and have the watchdog
core fail over to the third wathcdog omap_prcm_wdt_ioctl() that
only implements WDIOC_GETBOOTSTATUS? Or something like that.

Regards,

Tony
