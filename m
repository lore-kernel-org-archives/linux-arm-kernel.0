From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 29 May 2012 12:53:38 -0500
Subject: [PATCH 2/3] OMAP: avoid build wdt platform device if with dt
 support
In-Reply-To: <1337942552-28218-3-git-send-email-jgq516@gmail.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
 <1337942552-28218-3-git-send-email-jgq516@gmail.com>
Message-ID: <4FC50D22.4090409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/25/2012 05:42 AM, jgq516 at gmail.com wrote:
> From: Xiao Jiang <jgq516@gmail.com>
> 
> If provided dt support, then skip add wdt platform device as usual.
> 
> Signed-off-by: Xiao Jiang <jgq516@gmail.com>
> ---
>  arch/arm/mach-omap2/devices.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index ae62ece..80d7e3f 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -759,7 +759,7 @@ static int __init omap_init_wdt(void)
>  	char *oh_name = "wd_timer2";
>  	char *dev_name = "omap_wdt";
>  
> -	if (!cpu_class_is_omap2())
> +	if (!cpu_class_is_omap2() || of_have_populated_dt())
>  		return 0;
>  
>  	oh = omap_hwmod_lookup(oh_name);

Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
