From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Dec 2012 18:47:14 +0000
Subject: [GIT PULL v2] ARM: arm-soc fixes for 3.8
In-Reply-To: <CAOesGMgxXmXUW2RP_5AxJ6Z5sRBhFJ2CQz4S12MwXAb3=ibYOA@mail.gmail.com>
References: <20121220163814.GA29557@quad.lixom.net>
 <20121220175639.GA14363@n2100.arm.linux.org.uk>
 <CAOesGMgxXmXUW2RP_5AxJ6Z5sRBhFJ2CQz4S12MwXAb3=ibYOA@mail.gmail.com>
Message-ID: <20121220184714.GB14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 10:08:42AM -0800, Olof Johansson wrote:
> On Thu, Dec 20, 2012 at 9:56 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Dec 20, 2012 at 08:38:14AM -0800, Olof Johansson wrote:
> >> One of the sunxi patches from the last pull request was misapplied (I
> >> realized what happened -- git am -s didn't apply cleanly so I had done it
> >> through regular patch, thus not catching the renames properly). Here's
> >> a fresh version of the pull request with a couple more OMAP and Samsung
> >> patches included.
> >>
> >> There's a chance that a couple of the OMAP patches will also go in through
> >> Russell, since my connectivity has been crap so far this trip and it
> >> causes build breaks for the platform. It's a branch pull from Tony,
> >> it should be a no-op either way.
> >
> > Olof,
> >
> > Not sure what's going on, but my recent pull from arm-soc for-next still
> > hasn't solved the OMAP build failures in my kbuild - I'm still getting:
> >
> > arch/arm/mach-omap2/timer.c: In function 'omap_get_timer_dt':
> > arch/arm/mach-omap2/timer.c:178:3: error: implicit declaration of function 'prom_add_property'
> > arch/arm/mach-omap2/i2c.c: In function 'omap_pm_set_max_mpu_wakeup_lat_compat':
> > arch/arm/mach-omap2/i2c.c:130:2: error: implicit declaration of function 'omap_pm_set_max_mpu_wakeup_lat'
> 
> Yep, I forgot to bring the fixes branch into our for-next. Try again
> once it mirrors out, I just pushed out a rebuild of it. New top commit
> should be e691d77e8825054376b31e79a9b5f9fa79fe764d.

Yes, this looks much better, thanks.
