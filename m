From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 23 Mar 2013 09:22:20 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBhdXRjcHUxMjogRml4IGNvbmZpZyBjaGVjayBp?=
 =?UTF-8?B?biBhdXRjcHUxMl9pbml0X2xhdGUoKQ==?=
In-Reply-To: <1363988123.3728.45.camel@deadeye.wl.decadent.org.uk>
References: <1363988123.3728.45.camel@deadeye.wl.decadent.org.uk>
Message-ID: <1364016140.352883792@f399.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The 'CONFIG_' prefix is not implicit in IS_ENABLED().
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Paul Bolle <pebolle@tiscali.nl>
> Cc: <stable@vger.kernel.org> # 3.8+
> ---
> Found by inspection.  This is not even compile-tested.
> 
> Ben.
> 
>  arch/arm/mach-clps711x/board-autcpu12.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
> index f385847..8138523 100644
> --- a/arch/arm/mach-clps711x/board-autcpu12.c
> +++ b/arch/arm/mach-clps711x/board-autcpu12.c
> @@ -158,7 +158,8 @@ static void __init autcpu12_init(void)
>  
>  static void __init autcpu12_init_late(void)
>  {
> -	if (IS_ENABLED(MTD_NAND_GPIO) && IS_ENABLED(GPIO_GENERIC_PLATFORM)) {
> +	if (IS_ENABLED(CONFIG_MTD_NAND_GPIO) &&
> +	    IS_ENABLED(CONFIG_GPIO_GENERIC_PLATFORM)) {
>  		/* We are need both drivers to handle NAND */
>  		platform_device_register(&autcpu12_nand_pdev);
>  	}

Oops. Right.
And I think checks can be removed completely.

---
