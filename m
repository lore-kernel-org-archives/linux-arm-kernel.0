From: giedrius.statkevicius@gmail.com (=?UTF-8?B?R2llZHJpdXMgU3RhdGtldmnEjWl1cw==?=)
Date: Fri, 13 Mar 2015 16:47:30 +0200
Subject: [PATCH 10/10] mach-osiris-dvs.c : use "&&" (not "&") with bool
 operands
In-Reply-To: <1426257067-5723-1-git-send-email-ameenali023@gmail.com>
References: <1426257067-5723-1-git-send-email-ameenali023@gmail.com>
Message-ID: <5502F882.2010502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015.03.13 16:31, Ameen Ali wrote:
> itwise AND ("&") was used
> in logical expressions with operands having "bool" type. Replaced
> bitwise AND operators with logical AND.
> 
> Signed-off-by : <AmeenAli023@gmail.com
This line's messed up. The correct format is:
Signed-off-by: Full name <email>
Always use checkpatch to check the .patch for these kinds of issues.
Also the Subject: is not properly formatted. Usually we do something
like:
subsystem/architecture: bla bla bla
You can look at the 'git log' for examples and format it similarly.

> ---
>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
> index ce2db23..e189836 100644
> --- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
> +++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
> @@ -70,16 +70,16 @@ static int osiris_dvs_notify(struct notifier_block *nb,
>  
>  	switch (val) {
>  	case CPUFREQ_PRECHANGE:
> -		if (old_dvs & !new_dvs ||
> -		    cur_dvs & !new_dvs) {
> +		if (old_dvs && !new_dvs ||
> +		    cur_dvs && !new_dvs) {
>  			pr_debug("%s: exiting dvs\n", __func__);
>  			cur_dvs = false;
>  			gpio_set_value(OSIRIS_GPIO_DVS, 1);
>  		}
>  		break;
>  	case CPUFREQ_POSTCHANGE:
> -		if (!old_dvs & new_dvs ||
> -		    !cur_dvs & new_dvs) {
> +		if (!old_dvs && new_dvs ||
> +		    !cur_dvs && new_dvs) {
>  			pr_debug("entering dvs\n");
>  			cur_dvs = true;
>  			gpio_set_value(OSIRIS_GPIO_DVS, 0);
> 


-- 
Thanks,
Giedrius
