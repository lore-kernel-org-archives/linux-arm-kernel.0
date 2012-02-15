From: khilman@ti.com (Kevin Hilman)
Date: Wed, 15 Feb 2012 11:37:33 -0800
Subject: [PATCHv2 8/8] arm: omap3: prevent per_clkdm from attempting
 manual domain transitions
In-Reply-To: <1329320274-481-9-git-send-email-t-kristo@ti.com> (Tero Kristo's
 message of "Wed, 15 Feb 2012 17:37:54 +0200")
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
 <1329320274-481-9-git-send-email-t-kristo@ti.com>
Message-ID: <87pqdf99c2.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> Attempting this will cause problems especially with off-mode enabled.

Please be more verbose about the problems seen, and the root cause(s).

Kevin

> Previously this issue was hidden by the fact that per_clkdm never
> attempted manual idle by software, as the usecounts for the clockdomain
> were broken.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/clockdomains3xxx_data.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> index b84e138..db31bbf 100644
> --- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> @@ -282,7 +282,7 @@ static struct clockdomain usbhost_clkdm = {
>  static struct clockdomain per_clkdm = {
>  	.name		= "per_clkdm",
>  	.pwrdm		= { .name = "per_pwrdm" },
> -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP | CLKDM_NO_MANUAL_TRANS,
>  	.dep_bit	= OMAP3430_EN_PER_SHIFT,
>  	.wkdep_srcs	= per_wkdeps,
>  	.sleepdep_srcs	= per_sleepdeps,
