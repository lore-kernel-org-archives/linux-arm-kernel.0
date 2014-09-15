From: nm@ti.com (Nishanth Menon)
Date: Mon, 15 Sep 2014 13:00:44 -0500
Subject: [PATCH] Input: palmas-pwrbutton: Fix typo in License
In-Reply-To: <1410803937-27022-1-git-send-email-nm@ti.com>
References: <1410803937-27022-1-git-send-email-nm@ti.com>
Message-ID: <5417294C.2010506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2014 12:58 PM, Nishanth Menon wrote:
> Follow the license string convention indicated in include/linux/module.h
> (don't capitalize v).
> 
> This fixes following randconfig warning:
> FATAL: modpost: GPL-incompatible module palmas-pwrbutton.ko uses GPL-only symbol 'platform_driver_unregister'
> 
Uggh.. forgot to add:

Fixes: adff5962fdd2 ("Input: introduce palmas-pwrbutton")

> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Jim Davis <jim.epost@gmail.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Reported thread http://marc.info/?l=linux-input&m=141080223209150&w=2
> 
>  drivers/input/misc/palmas-pwrbutton.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
> index 3f90211..4ed6f78 100644
> --- a/drivers/input/misc/palmas-pwrbutton.c
> +++ b/drivers/input/misc/palmas-pwrbutton.c
> @@ -326,5 +326,5 @@ module_platform_driver(palmas_pwron_driver);
>  
>  MODULE_ALIAS("platform:palmas-pwrbutton");
>  MODULE_DESCRIPTION("Palmas Power Button");
> -MODULE_LICENSE("GPL V2");
> +MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Texas Instruments Inc.");
> 

-- 
Regards,
Nishanth Menon
