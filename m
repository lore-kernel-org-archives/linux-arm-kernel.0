From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Wed, 11 May 2016 08:59:24 +0800
Subject: [PATCH 2/2] ARM64: dts: rockchip: enable eMMC for rk3399 EVB
In-Reply-To: <1462924975-69072-2-git-send-email-briannorris@chromium.org>
References: <1462924975-69072-1-git-send-email-briannorris@chromium.org>
 <1462924975-69072-2-git-send-email-briannorris@chromium.org>
Message-ID: <d8dc5609-3cf6-80ce-462b-d46f0ea6dcff@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/5/11 8:02, Brian Norris wrote:
> The 'mmc-hs400-enhanced-strobe' property has been acked by Rob Herring,
> though it's still not merged.
>

Hi Brain,

I'm not sure whether it's acceptable to upstream new property which
isn't merged yet. My major concern is that as the patchset supporting
h400es will go through mmc tree, so if Ulf should want to shorten the
name (e.g mmc-hs400-es), you would respin this patch.


Thanks.

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> index 1a3eb1482050..ccfd2bcf02e1 100644
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
> +	status = "okay";
> +};
> +
>  &uart2 {
>  	status = "okay";
>  };
>


-- 
Best Regards
Shawn Lin
