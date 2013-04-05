From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Apr 2013 14:34:34 -0700
Subject: [PATCH v3 2/4] ARM: OMAP4+: PM: Consolidate OMAP4 PM code to
 re-use it for OMAP5
In-Reply-To: <1365166743-5940-3-git-send-email-santosh.shilimkar@ti.com>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130405213433.GF10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130405 06:01]:
> OMAP5 has backward compatible PRCM block and it's programming
> model is mostly similar to OMAP4. Same is going to be maintained
> for future OMAP4 based SOCs. Hence consolidate the OMAP4 power
> management code so that it can be re-used on OMAP5 and later devices.
> 
> While at it, update the kernel-doc for omap4_pm_init().
> 
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                       |    9 +--
>  arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c}   |   58 ++++++++++++++++----
>  .../mach-omap2/{sleep44xx.S => sleep_omap4plus.S}  |    0
>  3 files changed, 53 insertions(+), 14 deletions(-)
>  rename arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c} (83%)
>  rename arch/arm/mach-omap2/{sleep44xx.S => sleep_omap4plus.S} (100%)

I suggest you leave out the rename. That just adds churn and has
flame potential.

Regards,

Tony
