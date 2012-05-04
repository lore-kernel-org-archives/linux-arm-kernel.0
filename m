From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 16:56:55 -0700
Subject: [PATCH 00/15] arch/arm/mach-* late_initcall cleanup
In-Reply-To: <20120502133757.GB2194@S2101-09.ap.freescale.net>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
 <201205021245.02831.arnd@arndb.de>
 <20120502133757.GB2194@S2101-09.ap.freescale.net>
Message-ID: <20120504235655.GC5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo <shawn.guo@linaro.org> [120502 06:41]:
> On Wed, May 02, 2012 at 12:45:02PM +0000, Arnd Bergmann wrote:
> > On Wednesday 02 May 2012, Shawn Guo wrote:
> > > This series tries to clean up those late_initcall in arch/arm/mach-*,
> > > which will be a blocker for single kernel build for multiple platforms.
> > > Even on single platform, for example imx, where we already have single
> > > kernel image for imx3, imx5 and imx6 families, late_initcall does not
> > > scale.  We have to detect soc type in the late_initcall to do soc
> > > sepcific late initialization.
> > 
> > Hi Shawn,
> > 
> > If you're targetting this at v3.5, I think we should get it into arm-soc
> > as a staging branch to give it some more testing in linux-next ASAP.
> > 
> Thanks for the reminding, Arnd.  Yes, I'm targeting this at v3.5,
> since the imx cpuidle drivers from Rob Lee which targets at v3.5
> depends on it.

Sorro for being late in responding, these look good to me. For the
omap parts:

Acked-by: Tony Lindgren <tony@atomide.com>

Also ack to merge without my ack added for being late ;)

Tony
