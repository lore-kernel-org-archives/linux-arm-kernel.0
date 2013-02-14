From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 Feb 2013 08:24:26 +0900
Subject: [PATCH 5/9] ARM: shmobile: mark mackerel sh_mmcif_device
 __maybe_unused
In-Reply-To: <1360880818-4071454-6-git-send-email-arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
 <1360880818-4071454-6-git-send-email-arnd@arndb.de>
Message-ID: <20130214232426.GB30667@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 11:26:54PM +0100, Arnd Bergmann wrote:
> Patch eac036ef9e "ARM: shmobile: streamline mackerel SD and MMC devices"
> made the use of the sh_mmcif_device variable for mackarel optional,
> but the definition is always provided, causing a build warning.
> 
> arch/arm/mach-shmobile/board-mackerel.c:1120:31: warning: 'sh_mmcif_device'
> 	defined but not used [-Wunused-variable]
> 
> Marking the variable as __maybe_unused will do the right thing here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Simon Horman <horms+renesas@verge.net.au>

No objections here.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/mach-shmobile/board-mackerel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> index 0c78207..1de898f 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -1117,7 +1117,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
>  	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
>  };
>  
> -static struct platform_device sh_mmcif_device = {
> +static struct platform_device sh_mmcif_device __maybe_unused = {
>  	.name		= "sh_mmcif",
>  	.id		= 0,
>  	.dev		= {
> -- 
> 1.8.1.2
> 
