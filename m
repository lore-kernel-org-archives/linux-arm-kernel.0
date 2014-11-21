From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 13:55:43 +0100
Subject: [GIT PULL] ARM: imx: SoC updates for 3.19
In-Reply-To: <CAAQ0ZWS_=o6WrAmDbdfMDxdceMJkG0k5h_i3SqoXDOVLkcSS-w@mail.gmail.com>
References: <20141119070306.GF27759@dragon> <201411201730.04562.arnd@arndb.de>
 <CAAQ0ZWS_=o6WrAmDbdfMDxdceMJkG0k5h_i3SqoXDOVLkcSS-w@mail.gmail.com>
Message-ID: <2257892.t3t7utnvDU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 16:37:55 Shawn Guo wrote:
> On Fri, Nov 21, 2014 at 12:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The changes all look good, but could you please send them again based on
> > v3.18-rc1? I'm trying to avoid back-merges from upstream into the next
> > branches.
> 
> The imx/cleanup branch can simply be based on v3.18-rc1.  But I choose
> to base imx/soc on a latest -rc to resolve a conflict between commit
> 410ba8d4a0da (ARM: imx: clk-vf610: get input clocks from assigned
> clocks) and c72c553249bb (ARM: imx: clk-vf610: define PLL's clock
> tree).  The former one is currently sits on imx/soc branch, and the
> latter landed on -rc4 as a fix.  I think we can handle it in either
> way of the following two.
> 
> 1. Drop commit 410ba8d4a0da (ARM: imx: clk-vf610: get input clocks
> from assigned clocks) from imx/soc branch and send it as a fix for
> 3.18 right way.
> 
> 2. Keep 410ba8d4a0da on imx/soc and leave the merge conflict to Linus.
> 
> What's your preference?

I think the best approach in this case would be to rebase your series
on top of 410ba8d4a0da. next/soc already contains -rc3 but not
-rc4, so this would solve the backmerge problem nicely.

> >
> > Also, note that we've started splitting out defconfig changes into
> > a separate topic branch. Since you are rebasing anyway, please send
> > the defconfig change as a separate patch or pull request and also
> > update multi_v7_defconfig in the same way.
> 
> Okay, to keep it simple, I will squashed the defconfig updates into
> one patch and send it to you.

Ok, sounds good, thanks!

	Arnd
