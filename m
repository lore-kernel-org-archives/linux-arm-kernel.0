From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 18:03:43 -0800
Subject: [PATCH 0/9] arm/tegra: Various pinmux-related cleanups
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF176BE92A4A@HQMAIL01.nvidia.com>
References: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
 <20111218005702.GA4336@quad.lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92A4A@HQMAIL01.nvidia.com>
Message-ID: <20111220020343.GF27789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 09:49:57AM -0800, Stephen Warren wrote:
> Olof Johansson wrote at Saturday, December 17, 2011 5:57 PM:
> > On Fri, Dec 16, 2011 at 03:12:23PM -0700, Stephen Warren wrote:
> > > While working on switching Tegra to a new pinctrl-based pin mux driver,
> > > I made a bunch of small pinmux-related fixes; this patch series.
> > >
> > > This patch series will have a few small context conflicts with Peter
> > > De Schrijver's Tegra30 support. Peter's patch series should have
> > > priority over this one (i.e. be the one merged if it's difficult to
> > > merge both).
> > 
> > Contents of the series as a whole looks good to me, but I did notice a
> > bunch of section mismatches. Instead of commenting on the specific
> > ones, just compile with CONFIG_DEBUG_SECTION_MISMATCH=y and fix up the
> > new ones and repost, please. :)
> 
> Just to close the loop on our IRC conversation, I believe those problems
> were introduced by the pinmux rework in Peter's T30 patches rather than
> my patch series. In particular, some in:
> 
> 6996e08 arm/tegra: prepare pinmux code for multiple tegra variants
> 
> And some in:
> 
> 241682c arm/tegra: pinmux tables and definitions for tegra30
> 
> Although the latter don't show up until:
> 
> 44107d8 arm/tegra: implement support for tegra30
> 
> Since that actually creates the Kconfig option that allows the T30 pinmux
> code to be built.
> 
> I'll take a look and come up with a patch for this that can be applied to
> Tegra's for-3.3/soc branch.

Yep, sounds good. Applied this series to for-3.3/boards -- thanks!


-Olof
