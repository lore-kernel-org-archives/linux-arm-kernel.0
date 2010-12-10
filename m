From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 09 Dec 2010 16:36:13 -0800
Subject: [PATCH 0/5] OMAP4: hwmod data fixes and update
In-Reply-To: <1291937615-18571-1-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 10 Dec 2010 00:33:30 +0100")
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Message-ID: <87hbem4g76.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> Hi Paul,
>
> Here is a small set of OMAP4 hwmod data updates.
>
> Re-order properly the data that were a little bit shuffled during
> the previous merge window.
> Add the new reset flags introduced in 2.6.37 and that were not
> used in the hwmod data. The OMAP2 and OMAP3 fixes should come soon.
> Fix some missing field in the GPIO OMAP4 hwmod data that I missed
> during the review.
> IVA and DSP are added just to allow the processors device creation
> at boot time and avoid the warnings.
>
> Thanks to Charu for testing the GPIO / WD_TIMER changes.
> Thanks to Govindraj for testing the UART changes. 
>
> The series is based on lo/for-next (v2.6.37-rc5-66-ga2814df) and is
> available here:
> git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_data
>
> Please note that there is a slight dependency with the following patch
> due to the name change of the iva fclk:
> OMAP4: clock data: Add missing DPLL x2 clock node
> https://patchwork.kernel.org/patch/396612/
>
> Tested on sdp4430 + ES2.0/ES2.1.

As with the other series, I tried to pull this into my pm-core for
testing with all the other PM stuff we have baking for 2.6.38.

Unfortunately, this series has conflicts with Paul's
pwrdm_prcm_[ab]_2.6.38 branches.

Could you rebase this on Paul's pwrdm_prcm_b_2.6.38 branch?

Kevin

>
> Regards,
> Benoit
>
>
> Benoit Cousson (5):
>   OMAP4: hwmod data: Fix hwmod entries order
>   OMAP4: hwmod data: Add SYSS_HAS_RESET_STATUS flag
>   OMAP4: hwmod data: Fix missing address in DMM and EMIF_FW
>   OMAP4: hwmod data: Add IVA and DSP
>   OMAP4: hwmod & clock data: Fix GPIO opt_clks and ocp_if iclk
>
>  arch/arm/mach-omap2/clock44xx_data.c       |   12 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1256 ++++++++++++++++++----------
>  2 files changed, 822 insertions(+), 446 deletions(-)
