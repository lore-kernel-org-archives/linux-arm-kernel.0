From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Feb 2014 09:35:21 -0500
Subject: [PATCH 16/21] drivers: Enable building of Kirkwood drivers for
 mach-mvebu
In-Reply-To: <20140207091336.GC17758@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-17-git-send-email-andrew@lunn.ch>
 <20140207015915.GQ8533@titan.lakedaemon.net>
 <20140207091336.GC17758@lunn.ch>
Message-ID: <20140207143521.GW8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:13:36AM +0100, Andrew Lunn wrote:
> On Thu, Feb 06, 2014 at 08:59:15PM -0500, Jason Cooper wrote:
> > On Fri, Feb 07, 2014 at 12:42:12AM +0100, Andrew Lunn wrote:
> > > With the move to mach-mvebu, drivers Kconfig need tweeking to allow
> > > the kirkwood specific drivers to be built.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > >  drivers/cpufreq/Kconfig.arm | 2 +-
> > >  drivers/cpuidle/Kconfig.arm | 2 +-
> > >  drivers/leds/Kconfig        | 4 ++--
> > >  drivers/phy/Kconfig         | 2 +-
> > >  drivers/thermal/Kconfig     | 2 +-
> > >  sound/soc/kirkwood/Kconfig  | 2 +-
> > >  6 files changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > > index 31297499a60a..de931081fd01 100644
> > > --- a/drivers/cpufreq/Kconfig.arm
> > > +++ b/drivers/cpufreq/Kconfig.arm
> > > @@ -113,7 +113,7 @@ config ARM_INTEGRATOR
> > >  	  If in doubt, say Y.
> > >  
> > >  config ARM_KIRKWOOD_CPUFREQ
> > > -	def_bool ARCH_KIRKWOOD && OF
> > > +	def_bool (ARCH_KIRKWOOD || MACH_KIRKWOOD) && OF
> > 
> > I agree with creating MACH_KIRKWOOD underneath ARCH_MVEBU earlier in
> > this series, but the 'ARCH_KIRKWOOD || MACH_KIRKWOOD' just looks
> > confusing.

Hmm, I was tired last night.  I should've offered a suggestion with my
complaint :)  Unfortunately, the only thing I can come up with is a
oneline comment explaining DT/non-DT...  other ideas?  Or, not worth the
effort?

thx,

Jason.
