From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Aug 2011 10:25:04 +0200
Subject: [PATCH] ARM: imx: pwm: Add support for MX53
In-Reply-To: <1314116798-12755-1-git-send-email-fabio.estevam@freescale.com>
References: <1314116798-12755-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110824082504.GJ16557@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Tue, Aug 23, 2011 at 01:26:38PM -0300, Fabio Estevam wrote:
> Instead of adding the check for MX53 CPU type, use the negative logic and let 
> PWM to be configured for MX53 as well.
I wonder why you prefer negative logic here. It might be shorter, but it
is also less robust. For example it seems to me you not only added
support for i.MX53 but also i.MX50.

The IMHO best solution would be to use device ids and get rid of
cpu_is_mx.. completely.

Best regards
Uwe
>  arch/arm/plat-mxc/pwm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
> index 761c3c9..42d74ea 100644
> --- a/arch/arm/plat-mxc/pwm.c
> +++ b/arch/arm/plat-mxc/pwm.c
> @@ -57,7 +57,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
>  	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
>  		return -EINVAL;
>  
> -	if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
> +	if (!(cpu_is_mx1() || cpu_is_mx21())) {
>  		unsigned long long c;
>  		unsigned long period_cycles, duty_cycles, prescale;
>  		u32 cr;

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
