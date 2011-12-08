From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 8 Dec 2011 22:56:54 +0800
Subject: [RFC PATCH 0/8] Add common ARM cpuidle init code
In-Reply-To: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
Message-ID: <20111208145653.GF7913@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 10:38:03PM -0600, Robert Lee wrote:
> The patchset adds some cpuidle initialization functionality commonly
> duplicated by many ARM platforms.  The duplicate cpuidle init code of the
> various ARM platforms has been modified to use this common code.
> The omap cpuidle initialization impelmentation doesn't quite fit into
> this common framework so it was left alone.
> 
> All the modified ARM platforms were built against the new code and
> tests were ran on a i.MX51 Babbage board using the new mx5 cpuidle
> implementation included in this patchset.
> 
> Questions: 
> 
> Is arch/arm/common/ the correct location for this code?
> 
With many drivers are being moved into drivers/* from arch/arm/mach-*
and arch/arm/plat-*, I'm wondering if we have any problem with doing
the same thing on cpuidle.  If we can move these cpuidle drivers into
drivers/cpuidle (or drivers/idle, I'm not sure why two folders), that
will be the best place for such consolidation to me.

Cc-ed linux-pm and Len Brown for helping understand.

Regards,
Shawn

> Should the mx5 implementation be moved to a separate patchset?
> 
> Robert Lee (8):
>   ARM: Add commonly used cpuidle init code
>   ARM: at91: Replace init with new common ARM cpuidle init code
>   ARM: kirkwood: Replace init with new common ARM cpuidle init code
>   ARM: exynos: Replace init with new common ARM cpuidle init code
>   ARM: davinci: Replace init with new common ARM cpuidle init code
>   ARM: shmobile: Replace init with new common ARM cpuidle init code
>   ARM: imx: Add mx5 clock changes necessary for low power
>   ARM: imx: Add mx5 cpuidle implmentation
> 
>  arch/arm/common/Makefile            |    1 +
>  arch/arm/common/cpuidle.c           |  132 +++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/cpuidle.h      |   25 +++++++
>  arch/arm/mach-at91/cpuidle.c        |   68 ++++++------------
>  arch/arm/mach-davinci/cpuidle.c     |   73 ++++++-------------
>  arch/arm/mach-exynos/cpuidle.c      |   66 +++--------------
>  arch/arm/mach-kirkwood/cpuidle.c    |   63 ++++++-----------
>  arch/arm/mach-mx5/Makefile          |    3 +-
>  arch/arm/mach-mx5/clock-mx51-mx53.c |    3 +
>  arch/arm/mach-mx5/cpuidle.c         |   59 ++++++++++++++++
>  arch/arm/mach-shmobile/cpuidle.c    |   33 ++-------
>  11 files changed, 308 insertions(+), 218 deletions(-)
>  create mode 100644 arch/arm/common/cpuidle.c
>  create mode 100644 arch/arm/include/asm/cpuidle.h
>  create mode 100644 arch/arm/mach-mx5/cpuidle.c
