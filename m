From: bsteinsbo@gmail.com (Bjarne Steinsbo)
Date: Tue, 20 Sep 2011 16:27:15 +0200
Subject: [PATCH] usb: musb: OMAP4430: Remove a redundant omap4430_phy_init
	call in usb_musb_init
In-Reply-To: <1316508629.14514.2.camel@phoenix>
References: <1316508629.14514.2.camel@phoenix>
Message-ID: <CAFULf_xq8E1hvB6sXKfwxo6PS39mN0Xe15nevmNReCtfcJ90tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ref thread starting at http://marc.info/?l=linux-omap&m=131316289211258&w=2

Bjarne Steinsbo

On Tue, Sep 20, 2011 at 10:50 AM, Axel Lin <axel.lin@gmail.com> wrote:
> Current code calls omap4430_phy_init() twice in usb_musb_init().
> Calling omap4430_phy_init() once is enough.
> This patch removes the first omap4430_phy_init() call, which using an
> uninitialized pointer as parameter.
>
> This patch elimates below build warning:
> arch/arm/mach-omap2/usb-musb.c: In function 'usb_musb_init':
> arch/arm/mach-omap2/usb-musb.c:141: warning: 'dev' may be used uninitialized in this function
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> ?arch/arm/mach-omap2/usb-musb.c | ? ?3 ---
> ?1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index a65145b..19e4dac 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -137,9 +137,6 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
> ? ? ? ?musb_plat.mode = board_data->mode;
> ? ? ? ?musb_plat.extvbus = board_data->extvbus;
>
> - ? ? ? if (cpu_is_omap44xx())
> - ? ? ? ? ? ? ? omap4430_phy_init(dev);
> -
> ? ? ? ?if (cpu_is_omap3517() || cpu_is_omap3505()) {
> ? ? ? ? ? ? ? ?oh_name = "am35x_otg_hs";
> ? ? ? ? ? ? ? ?name = "musb-am35x";
> --
> 1.7.4.1
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
