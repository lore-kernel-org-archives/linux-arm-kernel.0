From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Mar 2011 21:48:35 +0000
Subject: [GIT PULL] u300, ux500 and Nomadik changes for v2.6.39
In-Reply-To: <AANLkTikgMq4QbRGZ_3kkzeNBp9aD4YKa-0CRCfs1K57u@mail.gmail.com>
References: <AANLkTikgMq4QbRGZ_3kkzeNBp9aD4YKa-0CRCfs1K57u@mail.gmail.com>
Message-ID: <20110313214835.GA24370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 09:18:43PM +0100, Linus Walleij wrote:
> Hi Russell,
> 
> if your harddrive is feeling better could you please pull:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> for-rmk
> 
> Based on commit dd9c1549edef02290edced639f67b54a25abbe0e:
> Linux 2.6.38-rc7 (2011-03-01 13:55:12 -0800)
> 
> For this set of patches that in short contain:
> - Numerous Nomadik GPIO pin updates for advaced stuff like
>   power management
> - Platform configuration of MUSB for ux500
> - Many platform data updates and refactorings, completing
>   the work to have a single kernel booting across all the
>   ux500 board variants.
> 
> All have been reviewed on the list before.
> Three of these patches may be duplicates of patches

I'm not merging trees which duplicate the patches in my tree.

> already merged in your tree:
>       ARM: 6644/1: mach-ux500: update the U8500 defconfig
>       ARM: perf_event: allow platform-specific interrupt handler
>       mach-ux500: DB8500 PMU support

This is annoying.  These are spread across three entirely different
branches:
"ARM: 6644/1" is part of the defcfg branch.
"ARM: perf_event" is part of someone elses tree merged into devel-stable.
"mach-ux500:" is "ARM: 6776/1:" and is part of the ux500 branch.

I'm intending sending some of these branches as entirely separate pulls
to Linus - particularly the defconfig and devel-stable branches (so that
Linus can see what code outside arch/arm is being modified by other
people and target his complaints about that more appropriately).

Merging your tree is going to destroy my ability to keep this stuff
strictly separate.

I don't mind merging the ux500 branch into devel-stable provided you're
not going to send any further ux500 patches?
