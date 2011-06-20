From: khilman@ti.com (Kevin Hilman)
Date: Mon, 20 Jun 2011 14:09:39 -0700
Subject: [PATCH] omap2+: pm: Fix section mismatch in pm_dbg_init()
In-Reply-To: <1308256260-15597-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Fri, 17 Jun 2011 02:01:00 +0530")
References: <1308256260-15597-1-git-send-email-premi@ti.com>
Message-ID: <87tybk6wh8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sanjeev Premi <premi@ti.com> writes:

> Fix the section mismatch warning:
>
>   WARNING: vmlinux.o(.text+0x21118): Section mismatch
>   in reference from the function pm_dbg_init() to the
>   function .init.text:pwrdms_setup()
>   The function pm_dbg_init() references
>   the function __init pwrdms_setup().
>   This is often because pm_dbg_init lacks a __init
>   annotation or the annotation of pwrdms_setup is wrong.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  Applies to current linux-omap master

A previous commit just removed the __init annotation here because of a
different conflict with the regset init.   The regset code is now
removed in my queue for 3.1, so this patch is fine on top of that
series.

Queueing for v3.1 (branch: for_3.1/pm-misc)

Thanks,

Kevin



>
>  arch/arm/mach-omap2/pm-debug.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index e01da45..ef33273 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -595,7 +595,7 @@ static int option_set(void *data, u64 val)
>  
>  DEFINE_SIMPLE_ATTRIBUTE(pm_dbg_option_fops, option_get, option_set, "%llu\n");
>  
> -static int pm_dbg_init(void)
> +static int __init pm_dbg_init(void)
>  {
>  	int i;
>  	struct dentry *d;
