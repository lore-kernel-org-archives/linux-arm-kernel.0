From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 13 May 2016 23:49:52 +0200
Subject: [PATCH v2 2/2] ARM64: dts: rockchip: enable eMMC for rk3399 EVB
In-Reply-To: <1463092552-60696-2-git-send-email-briannorris@chromium.org>
References: <1463092552-60696-1-git-send-email-briannorris@chromium.org>
 <1463092552-60696-2-git-send-email-briannorris@chromium.org>
Message-ID: <1537214.5jQgtQP16t@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 12. Mai 2016, 15:35:52 schrieb Brian Norris:
> Rockchip's rk3399 evaluation board has eMMC. Let's enable the
> newly-added node.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2:
> 
>  * better commit description
> 
>  arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts index
> 1a3eb1482050..0b27d91084c4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> @@ -89,6 +89,18 @@
>  	status = "okay";
>  };
> 
> +&emmc_phy {
> +	status = "okay";
> +};

another thing I should've seen yesterday, emmc_phy should not be below the 
&pwm nodes (aka alphabetically please)


Heiko

> +&sdhci {
> +	bus-width = <8>;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	non-removable;
> +	status = "okay";
> +};
> +
>  &uart2 {
>  	status = "okay";
>  };
