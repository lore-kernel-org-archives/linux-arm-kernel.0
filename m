From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 2 Mar 2018 13:49:59 +0000
Subject: [PATCH resend^2] ARM: nspire: Remove unneeded nspire_map_io()
In-Reply-To: <1519997885-12374-1-git-send-email-geert+renesas@glider.be>
References: <1519997885-12374-1-git-send-email-geert+renesas@glider.be>
Message-ID: <f87260a9-66a9-1f5c-4787-2632ad3daafb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/18 13:38, Geert Uytterhoeven wrote:
> nspire_map_io() just calls debug_ll_io_init().
> 
> If machine_desc.map_io is not set, devicemaps_init() in the
> common ARM code will call debug_ll_io_init(), so nspire_map_io() and the
> initialization of .map_io can be removed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I came to the similar conclusion some time ago with

d7da1ccfa2c2 "ARM: i.MX: remove map_io callback"

so, FWIW:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir

> ---
>  arch/arm/mach-nspire/nspire.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
> index f0808fcc5accad2e..8584cdd1c827687e 100644
> --- a/arch/arm/mach-nspire/nspire.c
> +++ b/arch/arm/mach-nspire/nspire.c
> @@ -33,11 +33,6 @@ static const char *const nspire_dt_match[] __initconst = {
>  	NULL,
>  };
>  
> -static void __init nspire_map_io(void)
> -{
> -	debug_ll_io_init();
> -}
> -
>  static struct clcd_board nspire_clcd_data = {
>  	.name		= "LCD",
>  	.caps		= CLCD_CAP_5551 | CLCD_CAP_565,
> @@ -71,7 +66,6 @@ static void nspire_restart(enum reboot_mode mode, const char *cmd)
>  
>  DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
>  	.dt_compat	= nspire_dt_match,
> -	.map_io		= nspire_map_io,
>  	.init_machine	= nspire_init,
>  	.restart	= nspire_restart,
>  MACHINE_END
> 
