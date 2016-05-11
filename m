From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 11 May 2016 16:51:58 +0200
Subject: [PATCH 2/2] ARM64: dts: rockchip: enable eMMC for rk3399 EVB
In-Reply-To: <1462924975-69072-2-git-send-email-briannorris@chromium.org>
References: <1462924975-69072-1-git-send-email-briannorris@chromium.org>
 <1462924975-69072-2-git-send-email-briannorris@chromium.org>
Message-ID: <4355979.JCGxOmTVBW@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

Am Dienstag, 10. Mai 2016, 17:02:55 schrieb Brian Norris:
> The 'mmc-hs400-enhanced-strobe' property has been acked by Rob Herring,
> though it's still not merged.

The commit message should describe the actual change not the volatile 
environment surrounding it :-) .

When I apply this patch the property-binding will have made it into a 
maintainer-tree so is not valid anymore then. That is more material for the 
"comment-section" below the "---"

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts index
> 1a3eb1482050..ccfd2bcf02e1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> @@ -89,6 +89,18 @@
>  	status = "okay";
>  };
> 
> +&emmc_phy {
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	mmc-hs400-1_8v;
> +	non-removable;
> +	mmc-hs400-enhanced-strobe;

alphabetic ordering of properties please

> +	status = "okay";
> +};
> +
>  &uart2 {
>  	status = "okay";
>  };
