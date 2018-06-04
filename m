From: horms@verge.net.au (Simon Horman)
Date: Mon, 4 Jun 2018 12:13:08 +0200
Subject: [PATCH 0/6] ARM: shmobile: rcar: Drop lehacy SYSC fallbacks
In-Reply-To: <1527693916-11215-1-git-send-email-geert+renesas@glider.be>
References: <1527693916-11215-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20180604101307.gwakbdqnka6arhxc@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 05:25:10PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> When DT SYSC support was introduced in v4.7, legacy fallbacks were kept
> to keep secondary CPUs working on R-Car H1, H2, and M2-W using old DTBs.
> However, the time has come to drop these fallbacks, and clean up the
> resulting code.
> 
> Most of this was written when I worked on DT SYSC support, but postponed
> until the time was ripe.  So basically I've been running this during the
> last +2 years.
> 
> I avoided touching drivers/soc/renesas and arch/arm/mach-shmobile code
> in the same patch.  If you prefer some patches to be squashed, please
> let me know.
> 
> Tested on Marzen (R-Car H1), Lager (R-Car H2), and Koelsch (R-Car M2-W).
> 
> Thanks!
> 
> Geert Uytterhoeven (6):
>   ARM: shmobile: rcar-gen2: Remove explicit SYSC config and init
>   ARM: shmobile: r8a7779: Stop powering down secondary CPUs during early
>     boot
>   soc: renesas: rcar-sysc: Provide helpers to power up/down CPUs
>   ARM: shmobile: r8a7779: Use rcar_sysc_power_{down,up}_cpu()
>   ARM: shmobile: r8a7779: Remove explicit SYSC config and init
>   soc: renesas: rcar-sysc: Drop legacy handling
> 
>  arch/arm/mach-shmobile/Makefile       |  2 +-
>  arch/arm/mach-shmobile/pm-r8a7779.c   | 41 ----------------------
>  arch/arm/mach-shmobile/pm-rcar-gen2.c | 25 --------------
>  arch/arm/mach-shmobile/r8a7779.h      |  2 --
>  arch/arm/mach-shmobile/smp-r8a7779.c  | 54 ++++-------------------------
>  drivers/soc/renesas/rcar-sysc.c       | 64 ++++++++++++++++++++++-------------
>  include/linux/soc/renesas/rcar-sysc.h | 13 ++-----
>  7 files changed, 50 insertions(+), 151 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/pm-r8a7779.c

Thanks, I have applied this and intend to push shortly.

I had a conflict in the Makefile when applying patch 5/6.
Please check to make sure I applied that patch correctly.
