From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 5 Nov 2018 10:19:37 +0100
Subject: [PATCH 05/14] ARM: ttc_dkb: add an instance of pxa-usb-phy
In-Reply-To: <20180822204307.13251-6-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-6-lkundrak@v3.sk>
Message-ID: <20181105091937.GG4439@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-08-22 22:42:58, Lubomir Rintel wrote:
> This will replace the ttc_usb_pdata.phy_{de,}init()>

">" -> "."?

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

>  arch/arm/mach-mmp/ttc_dkb.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index c7897fb2b6da..767dcb23ee1c 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -282,6 +282,10 @@ static void __init ttc_dkb_init(void)
>  				 sizeof(struct pxa_gpio_platform_data));
>  	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
>  
> +#if IS_ENABLED(CONFIG_PHY_PXA_USB)
> +	platform_device_register(&pxa168_device_usb_phy);
> +#endif


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/a273ff2c/attachment.sig>
