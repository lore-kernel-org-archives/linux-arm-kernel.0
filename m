From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 25 Oct 2012 19:31:06 +0000 (UTC)
Subject: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources
 pdata function pointer
In-Reply-To: <20121025191936.GZ11928@atomide.com>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013213.21844.20016.stgit@dusk.lan>
 <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
 <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com>
 <20121025185755.GV11928@atomide.com>
 <alpine.DEB.2.00.1210251908560.21193@utopia.booyaka.com>
 <20121025191936.GZ11928@atomide.com>
Message-ID: <alpine.DEB.2.00.1210251929500.21193@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2012, Tony Lindgren wrote:

> I wonder if we can now with multiple watchdogs supported to
> have also PRM/CM implement omap_prcm_wdt_ioctl() that just
> handles WDIOC_GETBOOTSTATUS and then just remove that handling
> from the other omap watchdog drivers?

The watchdog ioctl code needs access to internal watchdog state and 
functions, for example  WDIOC_KEEPALIVE and  WDIOC_SETTIMEOUT.  How would 
the approach you're thinking of implement those operations?



- Paul
