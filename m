From: khilman@ti.com (Kevin Hilman)
Date: Mon, 05 Mar 2012 16:33:31 -0800
Subject: [PATCHv3 1/4] ARM: OMAP4: suspend: Program all domains to
 retention
In-Reply-To: <1330529106-10423-2-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Wed, 29 Feb 2012 17:25:03 +0200")
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
 <1330529106-10423-2-git-send-email-t-kristo@ti.com>
Message-ID: <871up6in50.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Remove the FIXME's in the suspend sequence since
> we now intend to support system level RET support.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

So this is the only patch in this series that is still needed.  However...

It doesn't seem like this all by itself is ready for mainline as we'll
suddenly start putting all powerdomains in retention without any
additional support.

I guess at a minimum it needs working IO wakeup support from the IO
daisy chain series.  Are there other dependencies here?

If not, I can queue this when Paul is ready to merge the IO wakeup
stuff.

Kevin

> ---
>  arch/arm/mach-omap2/pm44xx.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index c264ef7..1ab30a3 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -151,12 +151,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  	if (!strncmp(pwrdm->name, "cpu", 3))
>  		return 0;
>  
> -	/*
> -	 * FIXME: Remove this check when core retention is supported
> -	 * Only MPUSS power domain is added in the list.
> -	 */
> -	if (strcmp(pwrdm->name, "mpu_pwrdm"))
> -		return 0;
>  
>  	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
>  	if (!pwrst)
