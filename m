From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Oct 2016 21:14:34 +0800
Subject: [PATCH] ARM: imx: mach-imx6q: Fix the PHY ID mask for AR8031
In-Reply-To: <1477312332-2027-1-git-send-email-festevam@gmail.com>
References: <1477312332-2027-1-git-send-email-festevam@gmail.com>
Message-ID: <20161024131434.GL30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 10:32:12AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> AR8031 and AR8035 have the same PHY ID mask of 0xffffffef.
> 
> So fix it and make it match with the PHY ID mask definition
> at drivers/net/phy/at803x.c.

It was working well with a wrong ID?

Shawn

> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 97fd251..45801b2 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -173,7 +173,7 @@ static void __init imx6q_enet_phy_init(void)
>  				ksz9021rn_phy_fixup);
>  		phy_register_fixup_for_uid(PHY_ID_KSZ9031, MICREL_PHY_ID_MASK,
>  				ksz9031rn_phy_fixup);
> -		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffff,
> +		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffef,
>  				ar8031_phy_fixup);
>  		phy_register_fixup_for_uid(PHY_ID_AR8035, 0xffffffef,
>  				ar8035_phy_fixup);
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
