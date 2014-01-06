From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Jan 2014 11:31:51 +0900
Subject: [PATCH 4/4] ARM: shmobile: lager: Make spi_flash_data const
In-Reply-To: <1388764128-27686-4-git-send-email-geert@linux-m68k.org>
References: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
 <1388764128-27686-4-git-send-email-geert@linux-m68k.org>
Message-ID: <20140106023151.GF11231@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 04:48:48PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>  arch/arm/mach-shmobile/board-lager.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index f20c10a18543..40ace7195f84 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -263,7 +263,7 @@ static struct mtd_partition spi_flash_part[] = {
>  	},
>  };
>  
> -static struct flash_platform_data spi_flash_data = {
> +static const struct flash_platform_data spi_flash_data = {
>  	.name           = "m25p80",
>  	.parts          = spi_flash_part,
>  	.nr_parts       = ARRAY_SIZE(spi_flash_part),

Should spi_flash_part also be const?

And should flash_platform_data and spi_flash_part be annotated
as __initconst?
