From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sat, 21 Dec 2013 00:05:38 +0100
Subject: [PATCH/RFC] ARM: omap3: Split the pinmux core device
In-Reply-To: <20131219183003.GR27438@atomide.com>
References: <1386177110-26424-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20131219171732.GB24230@earth.universe> <20131219183003.GR27438@atomide.com>
Message-ID: <2088462.QJuQNc7iK5@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thursday 19 December 2013 10:30:03 Tony Lindgren wrote:
> * Sebastian Reichel <sre@ring0.de> [131219 09:19]:
> > On Wed, Dec 04, 2013 at 06:11:50PM +0100, Laurent Pinchart wrote:
> > > The omap3_pmx_core pinmux device in the device tree handles the system
> > > controller module (SCM) PADCONFS fonction. Its control registers are
> > > split in two distinct areas, with other SCM registers in-between. Those
> > > other registers can't thus be requested by other drivers as the memory
> > > region gets reserved by the pinmux driver.
> > > 
> > > Split the omap3_pmx_core device tree node in two for the two memory
> > > regions.
> > > 
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > > 
> > >  arch/arm/boot/dts/omap3-beagle-xm.dts | 45 ++++++++++++++++++++++------
> > >  arch/arm/boot/dts/omap3-beagle.dts    | 28 +++++++++++++++-------
> > >  arch/arm/boot/dts/omap3-igep0020.dts  | 26 ++++++++++----------
> > >  arch/arm/boot/dts/omap3-zoom3.dts     | 19 ++++++++++-----
> > >  arch/arm/boot/dts/omap3.dtsi          | 13 +++++++++-
> > >  5 files changed, 95 insertions(+), 36 deletions(-)
> > > 
> > > While working on the OMAP3 ISP driver I've run into a failure to request
> > > a memory region already requested by the pinctrl-single driver. This
> > > patch is an attempt to fix the problem. An alternative approach would be
> > > to support multiple reg values in the pinctrl-single driver, but that
> > > might not be much cleaner. I'm open to suggestions.
> > 
> > Acked-By: Sebastian Reichel <sre@debian.org>
> > 
> > I haven't checked the board dts files, but the change in omap3.dtsi is
> > needed to "fix a external abort on non-linefetch" when doing
> > 
> > cat /sys/kernel/debug/pinctrl/.../pins
> > 
> > on my Nokia N900.
> 
> OK, that should be mentioned in the patch. Laurent, care to update the patch
> for that?

Done.

> We should also check that the register ranges match with Nishant's similar
> patch "[PATCH] ARM: dts: omap3: split pinctrl for core into two parts".

I've checked Nishanth's patch and updated mine as I had forgotten the LED pins 
on the IGEP boards. Reviewing the two patches side by side wouldn't hurt of 
course.

-- 
Regards,

Laurent Pinchart
