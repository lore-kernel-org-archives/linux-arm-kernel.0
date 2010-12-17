From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 17 Dec 2010 10:35:47 +0530
Subject: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
In-Reply-To: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
Message-ID: <f3afb9340d4f1d0c8d2936d9faea79c8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean,

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of jean.pihet at newoldbits.com
> Sent: Thursday, December 16, 2010 11:21 PM
> To: linux-omap at vger.kernel.org
> Cc: khilman at deeprootsystems.com; linux-arm-kernel at lists.infradead.org;
> Jean Pihet
> Subject: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
>
> From: Jean Pihet <j-pihet@ti.com>
>
> This patch only contains clean-ups and cosmetic changes,
> no functional change.
>
> Clean-up of the ASM sleep code, for better readability and
> easier maintenance.
>
> Applies on top of Nishant's latest idle path errata fixes step 2,
> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
>
Thanks for cleanup. Have few minor comments on these patches.

> Jean Pihet (7):
>   OMAP2+: use global values for the SRAM PA addresses
>   OMAP3: remove hardcoded values from the ASM sleep code
>   OMAP3: re-organize the ASM sleep code
>   OMAP3: rework of the ASM sleep code execution paths
>   OMAP3: add comments for low power code errata
>   OMAP3: ASM sleep code format rework
>   OMAP3: remove unused code from the ASM sleep code
>
>  arch/arm/mach-omap2/control.c   |   10 +-
>  arch/arm/mach-omap2/control.h   |    2 +
>  arch/arm/mach-omap2/pm.h        |    1 -
>  arch/arm/mach-omap2/pm34xx.c    |    4 +-
>  arch/arm/mach-omap2/sdrc.h      |    7 +
>  arch/arm/mach-omap2/sleep34xx.S |  714
+++++++++++++++++++++-------------
> -----
>  arch/arm/plat-omap/sram.c       |    7 +-
>  7 files changed, 401 insertions(+), 344 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
