From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 14:35:58 +0000
Subject: [PATCH v3 1/3] mfd: mc13xxx: add device tree probe support
In-Reply-To: <20111220135251.GB5129@S2101-09.ap.freescale.net>
References: <1323702958-4831-1-git-send-email-shawn.guo@linaro.org>
 <1323702958-4831-2-git-send-email-shawn.guo@linaro.org>
 <20111220005708.GM2860@opensource.wolfsonmicro.com>
 <20111220020101.GD5683@S2100-06.ap.freescale.net>
 <20111220015931.GX2860@opensource.wolfsonmicro.com>
 <20111220030347.GB2995@S2101-09.ap.freescale.net>
 <20111220112510.GL2866@opensource.wolfsonmicro.com>
 <20111220135251.GB5129@S2101-09.ap.freescale.net>
Message-ID: <20111220143558.GT2866@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 09:52:52PM +0800, Shawn Guo wrote:
> On Tue, Dec 20, 2011 at 11:25:11AM +0000, Mark Brown wrote:

> > Well, removing the random extra _s would be a big start (though I'd just
> > drop the chip name entirely from the name of the regulators since by the
> > time we're looking at the regulator we've already identified the chip)
> > and as I keep saying you need to document what the names mean - what are
> > the possible names and how do they map onto the hardware?

> I just came up with an idea which can totally avoid matching name.  It
> seems that we can identify a regulator using register plus enable bit,
> which is basically 'reg' and 'enable_bit' in 'mc13xxx_regulator'.  As
> these data must be coming from hardware manual, they should be stable
> enough for binding a regulator.  What do you think?

I don't know that that helps, register numbers and shifts aren't going
to do anything for legibility.  The problem with the names was that the
names chosen were poorly defined (why call DCDCn chipname__dcdcn?) and
not documented in the binding, not that they were names.
