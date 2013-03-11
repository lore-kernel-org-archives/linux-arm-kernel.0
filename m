From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 11 Mar 2013 13:40:55 +0000
Subject: [PATCH] ARM:vexpress: beautify code, using 'static const'
 instead of 'const static'
In-Reply-To: <513BF001.30204@asianux.com>
References: <513BF001.30204@asianux.com>
Message-ID: <1363009255.3165.19.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-03-10 at 02:29 +0000, Chen Gang wrote:
>   better using 'static const' instead of 'const static'
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/mach-vexpress/platsmp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index dc1ace5..9152bf7 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -40,7 +40,7 @@ static struct map_desc vexpress_dt_cortex_a9_scu_map __initdata = {
>  
>  static void *vexpress_dt_cortex_a9_scu_base __initdata;
>  
> -const static char *vexpress_dt_cortex_a9_match[] __initconst = {
> +static const char *vexpress_dt_cortex_a9_match[] __initconst = {
>  	"arm,cortex-a5-scu",
>  	"arm,cortex-a9-scu",
>  	NULL

Thanks for spotting this. I will keep this in mind, but I can't promise
to take this patch as it goes, because the platsmp.c is likely to change
(shrink) in near future. Either way I'll make sure you get due
credit :-)

Cheers!

Pawel
