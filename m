From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Jul 2015 17:10:06 +0800
Subject: [PATCH] ARM: dts: vf610: Nomenclature fixup for PTA6 pin used in
 RMII mode.
In-Reply-To: <1434124033-13820-1-git-send-email-andrew@lunn.ch>
References: <1434124033-13820-1-git-send-email-andrew@lunn.ch>
Message-ID: <20150708091006.GC28488@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 05:47:13PM +0200, Andrew Lunn wrote:
> Add a missing _ENET_ infix to PTA6 when used in RMII mode. This makes
> it consistent with all other pinctrl aliases for Ethernet.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

No, the existing naming is just fine, which follows how Vybrid Reference
Manual names them.

Shawn

> ---
>  arch/arm/boot/dts/vf-colibri.dtsi | 2 +-
>  arch/arm/boot/dts/vf610-pinfunc.h | 8 ++++----
>  arch/arm/boot/dts/vf610-twr.dts   | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
> index 68ca125b56ea..8e09b9f34a99 100644
> --- a/arch/arm/boot/dts/vf-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
> @@ -136,7 +136,7 @@
>  
>  		pinctrl_fec1: fec1grp {
>  			fsl,pins = <
> -				VF610_PAD_PTA6__RMII_CLKOUT		0x30d2
> +				VF610_PAD_PTA6__ENET_RMII_CLKOUT	0x30d2
>  				VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
>  				VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
>  				VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
> diff --git a/arch/arm/boot/dts/vf610-pinfunc.h b/arch/arm/boot/dts/vf610-pinfunc.h
> index fcad7132c871..61ccf6dfd1a7 100644
> --- a/arch/arm/boot/dts/vf610-pinfunc.h
> +++ b/arch/arm/boot/dts/vf610-pinfunc.h
> @@ -26,8 +26,8 @@
>  
>  
>  #define VF610_PAD_PTA6__GPIO_0			0x000 0x000 ALT0 0x0
> -#define VF610_PAD_PTA6__RMII_CLKOUT		0x000 0x000 ALT1 0x0
> -#define VF610_PAD_PTA6__RMII_CLKIN		0x000 0x2F0 ALT2 0x0
> +#define VF610_PAD_PTA6__ENET_RMII_CLKOUT	0x000 0x000 ALT1 0x0
> +#define VF610_PAD_PTA6__ENET_RMII_CLKIN		0x000 0x2F0 ALT2 0x0
>  #define VF610_PAD_PTA6__DCU1_TCON11		0x000 0x000 ALT4 0x0
>  #define VF610_PAD_PTA6__DCU1_R2			0x000 0x000 ALT7 0x0
>  #define VF610_PAD_PTA8__GPIO_1			0x004 0x000 ALT0 0x0
> @@ -36,8 +36,8 @@
>  #define VF610_PAD_PTA8__MLB_CLK			0x004 0x354 ALT7 0x0
>  #define VF610_PAD_PTA9__GPIO_2			0x008 0x000 ALT0 0x0
>  #define VF610_PAD_PTA9__TDI			0x008 0x000 ALT1 0x0
> -#define VF610_PAD_PTA9__RMII_CLKOUT		0x008 0x000 ALT2 0x0
> -#define VF610_PAD_PTA9__RMII_CLKIN		0x008 0x2F0 ALT3 0x1
> +#define VF610_PAD_PTA9__ENET_RMII_CLKOUT	0x008 0x000 ALT2 0x0
> +#define VF610_PAD_PTA9__ENET_RMII_CLKIN		0x008 0x2F0 ALT3 0x1
>  #define VF610_PAD_PTA9__DCU0_R1			0x008 0x000 ALT4 0x0
>  #define VF610_PAD_PTA9__WDOG_B			0x008 0x000 ALT6 0x0
>  #define VF610_PAD_PTA10__GPIO_3			0x00C 0x000 ALT0 0x0
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index 375ab23ca743..3f8e1b133bd1 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> @@ -203,7 +203,7 @@
>  
>  		pinctrl_fec0: fec0grp {
>  			fsl,pins = <
> -				VF610_PAD_PTA6__RMII_CLKIN		0x30d1
> +				VF610_PAD_PTA6__ENET_RMII_CLKIN		0x30d1
>  				VF610_PAD_PTC0__ENET_RMII0_MDC		0x30d3
>  				VF610_PAD_PTC1__ENET_RMII0_MDIO		0x30d1
>  				VF610_PAD_PTC2__ENET_RMII0_CRS		0x30d1
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
