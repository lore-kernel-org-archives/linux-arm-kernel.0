From: ben@datarespons.no (=?utf-8?B?QmrDuHJuIEVyaWsgTmlsc2Vu?=)
Date: Wed, 18 Dec 2013 12:12:05 +0100
Subject: imx6 power consumption
In-Reply-To: <20131218024546.GA6691@S2101-09.ap.freescale.net>
References: <E1VszO5-00060R-Gp@merlin.infradead.org>
 <20131218024546.GA6691@S2101-09.ap.freescale.net>
Message-ID: <mailman.19.1387365151.1056.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-12-18 at 03:45 +0100, Shawn Guo wrote:
> On Tue, Dec 17, 2013 at 07:28:27PM +0100, Bj?rn Erik Nilsen wrote:
> > Hi,
> > 
> > I have measured power consumption for imx6 in mem mode on the 3.12.4 mainstream kernel vs. 3.0.35 kernel from freescale/boundary devices. I noticed a significant increase going from 3.0 to 3.12 . I have at least identified one big difference: DDR is no longer tri-stated, which accounts for some of the difference.
> > 
> > I use 'echo mem > /sys/power/state' for my test case.
> > 
> > Do you know if someone is looking into this issue, or if there are pending patches somewhere?
> 
> It's an unimplemented feature rather than an issue.  There are some
> patches on Freescale 3.10 kernel, and you're welcomed to bring these
> patches to mainline kernel.


Right.

As far as I can tell, commit e95dddb34c8 "ARM: imx: enable anatop
suspend/resume" is the common ancestor for mainline and freescale, and
from there pm-imx6q.c starts to diverge.

I haven not looked at it in great detail yet, but it seems there are not
too many patches missing in mainline. Any idea why remaining patches
haven't been upstreamed?

If it is just a matter of someone doing the work, what would be the
recommended approach?


Best regards,
Bj?rn Erik Nilsen
