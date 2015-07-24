From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Jul 2015 21:18:58 -0700
Subject: [GIT PULL] ARM: OMAP2+: hwmod fixes for v4.2-rc
In-Reply-To: <alpine.DEB.2.02.1507231357020.29543@utopia.booyaka.com>
References: <alpine.DEB.2.02.1507231357020.29543@utopia.booyaka.com>
Message-ID: <20150724041857.GF16878@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Can you guys please pull this into arm soc fixes for v4.2 directly?

I don't have other omap fixes queued at this point.

Regards,

Tony

* Paul Walmsley <paul@pwsan.com> [150723 07:00]:
> Hi Tony,
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.2-rc/omap-fixes-a
> 
> for you to fetch changes up to 9a258afa928b45e6dd2efcac46ccf7eea705d35a:
> 
>   ARM: OMAP2+: hwmod: Fix _wait_target_ready() for hwmods without sysc (2015-07-23 06:35:25 -0600)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: hwmod fixes for v4.2-rc
> 
> Two fixes against v4.2-rc1.  The first, for DRA7xx platforms,
> corrects some incorrect GPMC hardware description data.  The
> second one will ensure that the hwmod code will wait for any
> module with CPU-accessible registers to become ready before
> attempting to access it.
> 
> Basic build, boot, and PM test logs are available here:
> 
> http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.2-rc/20150723065408/
> 
> Note that I do not have a DRA7xx or AM43xx board, and therefore
> cannot test on those platforms.
> 
> ----------------------------------------------------------------
> Roger Quadros (2):
>       ARM: DRA7: hwmod: fix gpmc hwmod
>       ARM: OMAP2+: hwmod: Fix _wait_target_ready() for hwmods without sysc
> 
>  arch/arm/mach-omap2/omap_hwmod.c          | 24 ++++++++++++++++--------
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  5 ++---
>  2 files changed, 18 insertions(+), 11 deletions(-)
