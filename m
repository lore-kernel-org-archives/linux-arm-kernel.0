From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Aug 2016 19:53:37 +0100
Subject: Bunch of CRC errors in next with arm: move exports to definitions
In-Reply-To: <20160826184605.4a4u4bxoknmdlgai@atomide.com>
References: <20160822162512.mptzbiaozx2fz42l@atomide.com>
 <20160826181910.ujtk325yqsmvfpbg@atomide.com>
 <20160826184605.4a4u4bxoknmdlgai@atomide.com>
Message-ID: <20160826185337.GY5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 11:46:06AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160826 11:20]:
> > * Tony Lindgren <tony@atomide.com> [160822 09:28]:
> > > Hi Al,
> > > 
> > > Looks like starting with next-20160818 I'm now getting close to
> > > 800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
> > > make modules:
> > ...
> > > Reverting commit 4dd1837d7589 ("arm: move exports to definitions")
> > > fixes it.
> > 
> > And not happening with multi_v7_defconfig for example. Adding Russell
> > to Cc, maybe he already has a fix for this one?
> 
> And this issue does not seem to happen with omap2plus_defconfig when
> compiled with:
> 
> gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29)
> 
> But does happen when compiled with:
> 
> gcc version 6.1.1 20160705 (Debian 6.1.1-9)

Hmm, if it's a "bleeding edge gcc" issue, I won't see it anyway, my
cross-compiler is still 4.7.4!  Even my ubuntu boxes are only on
4.8.4...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
