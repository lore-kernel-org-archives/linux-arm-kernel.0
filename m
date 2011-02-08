From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Feb 2011 19:57:10 -0700 (MST)
Subject: [PATCH v2 6/9] omap: dpll: Add allow_idle/deny_idle support for
	all DPLL's
In-Reply-To: <1296813544-25170-7-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
	<1296813544-25170-7-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1102071952300.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> All OMAP3/4 dpll's support hardware level autogating.
> Populate allow_idle/deny_idle function pointers for all
> DPLL's in clkops.
> 
> Also for OMAP4, call omap_clk_enable_autoidle() from PM
> core (only with CONFIG_PM) to enable hardware level
> autogating on all clock nodes which support it (For now
> only DPLL nodes)
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/clock.c          |    8 +++++++-
>  arch/arm/mach-omap2/clock.h          |    1 +
>  arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
>  arch/arm/mach-omap2/clock44xx_data.c |    2 +-
>  arch/arm/mach-omap2/pm44xx.c         |    4 ++++

Looks like you add the allow_idle/deny_idle functions for the OMAP3 CORE 
DPLL, but you don't change mach-omap2/pm34xx.c.  Any reason for this?  It 
seems that the current OMAP3 PM code doesn't enable CORE DPLL autoidle.  
Do you recall why?  Perhaps it is due to some of the autoidle bugs, where 
DPLL3 would enter auto-idle while some OMAP3 IP blocks that used CORE 
clocks were not idle...


- Paul
