From: khilman@ti.com (Kevin Hilman)
Date: Mon, 09 Apr 2012 15:40:49 -0700
Subject: [PATCH 07/17][V2] ARM: OMAP4: cpuidle - remove omap4_idle_data
 initialization at boot time
In-Reply-To: <1333570371-1389-8-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Wed, 4 Apr 2012 22:12:41 +0200")
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
 <1333570371-1389-8-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87ehrwa5qm.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> We initialized it at compile time, no need to do that at boot
> time.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |   26 +-------------------------
>  1 files changed, 1 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index b82f9fe..b0dd220 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -33,7 +33,7 @@ struct omap4_idle_statedata {
>  
>  #define OMAP4_NUM_STATES 3
>  
> -static struct omap4_idle_statedata omap4_idle_data[] = {
> +static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES] = {

You removed OMAP4_NUM_STATES usage in patch 5, why add it back here?

Kevin
