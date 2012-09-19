From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Sep 2012 11:15:28 +0800
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
In-Reply-To: <1348007837-23187-1-git-send-email-marex@denx.de>
References: <1348007837-23187-1-git-send-email-marex@denx.de>
Message-ID: <20120919031526.GC6460@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 12:37:17AM +0200, Marek Vasut wrote:
> Don't load the FEC MAC address from OCOTP, but use the one supplied
> via device tree by U-Boot. This is the preferred way, every DT-capable
> bootloader does set up "mac-address" and "local-mac-address" properties
> into the DT passed to the kernel.
> 
Ok, since you are the maintainer of m28evk board, it could be your call
to do so.  While for imx28-evk, the kernel at least runs with bootlets
which is not DT capable.

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-mxs/mach-mxs.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 170a930..71d47f5 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -255,8 +255,6 @@ static void __init imx28_evk_post_init(void)
>  
>  static void __init m28evk_init(void)
>  {
> -	update_fec_mac_prop(OUI_DENX);
> -

Since it's the only user of OUI_DENX, can we remove enum mac_oui
completely and make update_fec_mac_prop a fsl specific call?

Shawn

>  	mxsfb_pdata.mode_list = m28evk_video_modes;
>  	mxsfb_pdata.mode_count = ARRAY_SIZE(m28evk_video_modes);
>  	mxsfb_pdata.default_bpp = 16;
> -- 
> 1.7.10.4
> 
