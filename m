From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Feb 2013 15:34:07 -0800
Subject: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
In-Reply-To: <51103A25.9010401@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-3-git-send-email-jon-hunter@ti.com>
 <20130201215154.GV22517@atomide.com> <51103247.2030906@ti.com>
 <51103A25.9010401@ti.com>
Message-ID: <20130205233407.GR25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [130204 14:49]:
> 
> On 02/04/2013 04:12 PM, Jon Hunter wrote:
> > 
> > On 02/01/2013 03:51 PM, Tony Lindgren wrote:
> > 
> >> How about let's fix this properly to start with so we don't add
> >> more blockers moving this code to drivers/bus?
> >>
> >> Looks like gpmc_mem_init() gets called from gpmc_probe() so
> >> we can pass that information in pdev.
> > 
> > I have re-worked this a bit to use platform data. I have also update
> > the logic for testing internal/external boot on omap2430 which is
> > different from omap2420 (according to the TRM). However, I have only
> > boot tested on omap2420. 
> > 
> > Do you know why this was changed in the first place? See below ...
> > 
> > http://permalink.gmane.org/gmane.linux.kernel.commits.head/95931
> > 
> > Heres what I have now ...
> 
> Updated patch (I was missing a kfree()). By the way, this is based
> upon the apollon removal patch. I understand probably needs to be
> rebased on your latest gpmc series too.

Yeah makes sense to me thanks. I'll figure out where to apply this
so we don't get too many dependencies.

Regards,

Tony
