From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 3 Apr 2013 11:40:26 +0800
Subject: [GIT PULL] imx fixes for 3.9, take 5
In-Reply-To: <20130403031511.GB27874@quad.lixom.net>
References: <20130402134627.GF24039@S2101-09.ap.freescale.net>
 <20130403031511.GB27874@quad.lixom.net>
Message-ID: <20130403034023.GN24039@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 08:15:11PM -0700, Olof Johansson wrote:
> >  - One fix for the typo in use of Kconfig symbol
> >    MACH_EUKREA_CPUIMX27_USEUART4.  It's been there for a long time
> >    and got caught by code inspection recently.  It hasn't been noticed
> >    earlier probably because it does not cause any problem in real.
> 
> 2.6.35 to be exact.
> 
> It's more a sign that the board can be removed than that it should be fixed
> immediately for 3.9, wouldn't you say? Clearly no one seems to care about
> mainline functionality on that platform -- especially since it was now found
> through inspection and not usage.
> 
UART4 on the board is not cared or used by people does not necessarily
means that the board is not cared or used by people.  But I agree that
it's not an urgent fix for 3.9, and I will queue it for 3.10 as a
non-critical fix.

> >  - A couple of fixes on imx35 clock driver to have audmux functional
> >    and iomux pad configurable after a reboot.
> 
> These look like valid fixes but I can't from the commit messages tell
> when the problem was introduced, and what the actual breakage that the
> user sees it. It almost looks like it's adding a few clocks that were
> never used before, not a regression? I'm happy to be proven wrong though.
> 
I think these are regression caused by imx35 common clock migration.

> So, please resend with just the two clock fixes, as long as they are indeed
> regressions for something that used to work. Or I can just cherry-pick them
> over if you prefer.

Please just cherry-pick them, thanks.

Shawn
