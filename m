From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 17 Dec 2010 15:02:06 -0800
Subject: [PATCH 0/7 v5] OMAP3: clean up ASM sleep code
In-Reply-To: <1292580506-4421-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Fri, 17 Dec 2010 11:08:19 +0100")
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
Message-ID: <87bp4k6m1d.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

jean.pihet at newoldbits.com writes:

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

Can you do one more spin of this series in order to collect the
reviewed-by/tested-by tags posted, and address some of Nishanth's
comments.  Since we are reaching a merge window deadline, I'll leave it
to your discretion to decide which of Nishanth's suggestions to address
now and which to address later.

Kevin

> Jean Pihet (7):
>   OMAP2+: use global values for the SRAM PA addresses
>   OMAP3: remove hardcoded values from the ASM sleep code
>   OMAP3: re-organize the ASM sleep code
>   OMAP3: rework of the ASM sleep code execution paths
>   OMAP3: add comments for low power code errata
>   OMAP3: ASM sleep code format rework
>   OMAP3: remove unused code from the ASM sleep code
>
>  arch/arm/mach-omap2/control.c          |    9 +-
>  arch/arm/mach-omap2/control.h          |    2 +
>  arch/arm/mach-omap2/pm.h               |    1 -
>  arch/arm/mach-omap2/pm34xx.c           |    4 +-
>  arch/arm/mach-omap2/sdrc.h             |    1 -
>  arch/arm/mach-omap2/sleep34xx.S        |  724 +++++++++++++++++---------------
>  arch/arm/plat-omap/include/plat/sram.h |   11 +
>  arch/arm/plat-omap/sram.c              |    7 +-
>  8 files changed, 413 insertions(+), 346 deletions(-)
