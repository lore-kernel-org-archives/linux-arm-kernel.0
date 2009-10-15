From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 15 Oct 2009 21:15:01 +0400
Subject: [PATCH] gta02: set pcf50633 chg_ref_current_ma
In-Reply-To: <1255471148-29047-3-git-send-email-fercerpav@gmail.com>
References: <1255471148-29047-1-git-send-email-fercerpav@gmail.com>
	<1255471148-29047-2-git-send-email-fercerpav@gmail.com>
	<1255471148-29047-3-git-send-email-fercerpav@gmail.com>
Message-ID: <20091015171501.GA25775@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2009 at 01:59:05AM +0400, Paul Fertser wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> This value is board-specific and is needed for calculations to set charging
> current limit properly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Nelson Castillo <arhuaco@freaks-unidos.net>
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> ---
> 
> Since this patch compile-depends on previous probably it should go through
> the same tree as others. Nelson (gta02 maintainer) agrees with whatever you
> think is best.

I would happy to apply this patch via battery tree, along
with other your patches.

Just to make things clear: we no longer need RMK's Ack for
mach-specific patches that don't touch core code? Or maybe
Ben's Ack is still required?

Want to be on a safe side before applying.

Thanks!

>  arch/arm/mach-s3c2442/mach-gta02.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2442/mach-gta02.c b/arch/arm/mach-s3c2442/mach-gta02.c
> index 0fb385b..b0a3d74 100644
> --- a/arch/arm/mach-s3c2442/mach-gta02.c
> +++ b/arch/arm/mach-s3c2442/mach-gta02.c
> @@ -268,6 +268,9 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
>  
>  	.batteries = gta02_batteries,
>  	.num_batteries = ARRAY_SIZE(gta02_batteries),
> +
> +	.chg_ref_current_ma = 1000,
> +
>  	.reg_init_data = {
>  		[PCF50633_REGULATOR_AUTO] = {
>  			.constraints = {
> -- 
> 1.6.0.6

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
