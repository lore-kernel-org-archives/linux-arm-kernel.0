From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 2 Dec 2010 17:27:31 +0530
Subject: [PATCH 0/5] omap4: l2x0 fixes and cleanup
In-Reply-To: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <cc00e38ed5f706eff13e0fad542af71c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Friday, November 19, 2010 11:01 PM
> To: linux-omap at vger.kernel.org
> Cc: nm at ti.com; mans at mansr.com; tony at atomide.com;
> khilman at deeprootsystems.com; linux-arm-kernel at lists.infradead.org;
Santosh
> Shilimkar
> Subject: [PATCH 0/5] omap4: l2x0 fixes and cleanup
>
> This series is outcome of the below discussion thread.
> 	http://www.spinics.net/lists/arm-kernel/msg104254.html
>
> The series in brief has following patches
> 	- adds PL310 aux-control register bitfields
> 	- Use these bitfields instead of hardcoded values as part of init
> 	- Enable PL310 intsruction, Data prefetch hints and  BRESP to
> 		improve performance
> 	- Set share-override bit to avoid non-cached buffer corruption
>
> Thanks to Nishant Menon for testing this series on OMAP4 panda using
> the memspeed utility. Have boot tested this series on OMAP4 SDP with
> omap2plus_defconfig.
>
How about merging this series in omap-testing if you are ok
with it. Patch  " ARM: l2x0: Add aux control register bitfields"
is already acked by Catalin.

> The following changes since commit
> e53beacd23d9cb47590da6a7a7f6d417b941a994:
>   Linus Torvalds (1):
>         Linux 2.6.37-rc2
>
> Mans Rullgard (1):
>       omap4: l2x0: enable instruction and data prefetching
>
> Santosh Shilimkar (4):
>       ARM: l2x0: Add aux control register bitfields
>       omap4: l2x0: Construct the AUXCTRL value using defines
>       omap4: l2x0: Set share override bit
>       omap4: l2x0: Enable early BRESP bit
>
>  arch/arm/include/asm/hardware/cache-l2x0.h |   12 ++++++++++-
>  arch/arm/mach-omap2/omap4-common.c         |   30
+++++++++++++++++++++--
> ----
>  2 files changed, 34 insertions(+), 8 deletions(-)
