From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Apr 2013 09:04:01 -0700
Subject: [PATCH 0/3] WLAN support for omap4 when booted with devicetree
In-Reply-To: <1366957908.4029.15.camel@cumari.coelho.fi>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
 <1366957908.4029.15.camel@cumari.coelho.fi>
Message-ID: <20130426160400.GD29360@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Luciano Coelho <coelho@ti.com> [130425 23:38]:
> On Thu, 2013-04-25 at 20:52 -0700, Tony Lindgren wrote:
> > Hi all,
> 
> Hi Tony,
> 
> 
> > Here are some patches against linux next to make WLAN to work with
> > device tree. Note that we still are initializing wl12xx with pdata,
> > but so far it looks like only minimal binding for it is needed.
> 
> Thanks for doing this! I've been out on vacation for the past 3 weeks,
> so I didn't manage to finish the wl12xx DT stuff in time for 3.10. :(

OK I was wondering what happened.. 
 
> > There are various fixes pending posted recently, but at least the
> > fix "[PATCH] mmc: omap_hsmmc: Fix the DT pbias workaround for MMC
> > controllers 2 to 5" is needed.
> 
> I managed to apply the OMAP2+ and the blaze patches.  There were
> conflicts with the panda patch, so I skipped it for now.  I'll come back
> to it a bit later.

OK 
 
> > Please test on blaze/sdp if you have a chance, I don't have the
> > connectivity card on mine.
> 
> I tested this on Blaze and it seems to work fine! The driver gets probed
> and I can power the chip on and off (by putting the interface up and
> down) without any problems. :)

OK great thanks! It took me few hours of debugging to figure out that
it does not work on my blaze as I did not have the wl12xx card in it :)

Also can you fill in the missing GPIO lines for blaze from the schematics?
 
> BTW, did you (or anyone else) manage to get ethernet to work on Blaze
> (or Panda) with DT?

Yes that needs the two GPIO fixes posted by Jon Hunter last week.
One for patching in the GPIO trigger type to both omap4-sdp.dts, and
the other one is "gpio/omap: ensure gpio context is initialised".

Regards,

Tony
