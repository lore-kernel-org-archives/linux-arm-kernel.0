From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 29 May 2012 14:52:34 +0800
Subject: Regression for non-eMMC cards with commit fa550189?
In-Reply-To: <20120528132147.GC12766@atomide.com>
References: <20120528132147.GC12766@atomide.com>
Message-ID: <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

This patch changes the sequence of how the host drivers set_ios
function gets called during probe.

Before:
1. mmc_power_off
2. mmc_power_up

Now:
1. mmc_power_up

My guess is then; the omap driver set_ios function requires that
mmc_power_off is called before a mmc_power_up.
Hopefully this requirement can be removed and fixed in the host driver somehow.

Please get back to me if you need some more assistance around this matter.

Kind regards
Ulf Hansson


On 28 May 2012 21:21, Tony Lindgren <tony@atomide.com> wrote:
> Hi Ulf & Chris,
>
> Looks like commit fa550189 (mmc: core: Prevent eMMC VCC supply to be
> cut from late init) causes MMC card to stop working at least with
> n8x0 using drivers/mmc/host/omap.c. The card(s) on it are not eMMC.
>
> Reverting fa550189 makes things work again. Any ideas what could
> be causing this?
>
> No debug output from MMC_DEBUG, looks like commands won't even
> get started?
>
> Regards,
>
> Tony
