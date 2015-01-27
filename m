From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 27 Jan 2015 11:08:24 +0100
Subject: [PATCH v3 08/13] pm: at91: the standby mode uses the same sram
 function as the suspend to memory mode
In-Reply-To: <1422338300-5984-1-git-send-email-wenyou.yang@atmel.com>
References: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
 <1422338300-5984-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150127100824.GC32121@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On Tue, Jan 27, 2015 at 01:58:20PM +0800, Wenyou Yang wrote:
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 0377c0d..d967c31 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -71,7 +71,7 @@ static int at91_pm_begin(suspend_state_t state)
>   * Verify that all the clocks are correct before entering
>   * slow-clock mode.
>   */
> -static int at91_pm_verify_clocks(void)
> +static int at91_pm_verify_clocks(suspend_state_t state)
>  {
>  	unsigned long scsr;
>  	int i;
> @@ (...)

Unused state argument, it was added in v2, this is just a trace of a 
reverted v2 change not fully cleaned.


> +		if (!at91_pm_verify_clocks(state))
> +			goto error;

Ditto.


Sylvain
