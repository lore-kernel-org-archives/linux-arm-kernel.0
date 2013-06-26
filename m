From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jun 2013 10:15:22 +0100
Subject: OMAP baseline test results for v3.10-rc6
In-Reply-To: <51C9FC05.4070700@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org>
 <51C9FC05.4070700@ti.com>
Message-ID: <20130626091522.GT21614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 04:22:29PM -0400, Tom Rini wrote:
> On 06/25/2013 03:57 PM, Kevin Hilman wrote:
> > Just to confirm, my problems with mainline were with appended DTB also.
> > Separate DTB and zImage work fine (at least using u-boot v2013.04.)
> > 
> > That being said, appended DTB should still work, so there's a bug hiding
> > someplace that needs to be found fixed.
> 
> Since we've narrowed down what the problem is, someone can bisect it
> now, yeah.
> 
> > Can you guys update your tests to test appended DTB also?
> 
> What is the official position on appending DTBs?

If a platform goes from being able to boot without a DTB to requiring
a DTB, we must continue to support booting on that platform in some
manner otherwise it is a regression.

And no, I don't term upgrading uboot as an acceptable regression fix.
So if appended DTB doesn't work, that needs fixing before the non-DTB
support for a platform is removed, otherwise we _will_ have a regression.
