From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Jul 2014 09:46:17 -0700
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v3.17
In-Reply-To: <cover.1404174157.git.horms+renesas@verge.net.au>
References: <cover.1404174157.git.horms+renesas@verge.net.au>
Message-ID: <20140712164617.GE3954@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 09:28:47AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Second Round of Renesas ARM Based SoC Updates for v3.17.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-soc-for-v3.17,
> which I have already sent a pull-request for.
> 
> This conflicts with other changes made to pm-r8a7790.c in the soc branch
> of the renesas tree. A resolution can be found in the
> renesas-next-v3.16-rc1-20140628 tag of the next branch of that tree.
> 
> In short, the resulting includes should be:
> 
> #include <linux/kernel.h>
> #include <linux/smp.h>
> #include <asm/io.h>
> #include "common.h"
> #include "pm-rcar.h"
> #include "r8a7790.h"
> 
> 
> The following changes since commit 3ed66ec5ced8b801cb851b2b8548301df94f8f54:
> 
>   ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile (2014-06-23 09:53:55 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc2-for-v3.17
> 
> for you to fetch changes up to bfe4cfa8ae21628267f2b879b4396ee17ea4fd3a:
> 
>   ARM: shmobile: Allow r8a7791 to build non-SMP APMU code (2014-06-26 16:01:34 +0900)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC Updates for v3.17
> 
> * Suspend on non-SMP update for r8a7790
> * Move r8a7791.h out of mach directory.
>   This is part of a multi-stage effort to move headers
>   out of that directory.
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       ARM: shmobile: Move r8a7791.h

Merged, but:

This is a bit confused. You've now sent me three branches in this batch
alone that contain these header moves. One for next/soc that contained
nothing but a header move, one for cleanup that contained a whole bunch
of them, and now yet another one in this combined branch.

Please collect all of these in the cleanup branch, and make the soc branch
build on top of that if needed to avoid conflicts, instead of spreading them
out like this.

This is also where the conflict showed up that you mentioned in the
preceding pull request. To avoid that, I merged in your cleanup branch
on top, so that this conflict doesn't surface all the way up like it
otherwise would.


-Olof
