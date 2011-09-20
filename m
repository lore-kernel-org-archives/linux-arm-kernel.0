From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 20 Sep 2011 11:41:55 -0600
Subject: [PATCH REPOST 2/2] arm/dt: Tegra: Add support-8bit to SDHCI nodes
In-Reply-To: <1316537186-26753-2-git-send-email-swarren@nvidia.com>
References: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
	<1316537186-26753-2-git-send-email-swarren@nvidia.com>
Message-ID: <20110920174155.GG7781@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 10:46:26AM -0600, Stephen Warren wrote:
> For Seaboard's internal eMMC, this makes the difference between a
> 5.5MB/s and 10.2MB/s transfer rate. On Harmony, there wasn't any
> measurable difference on my cheap/slow ~2MB/s card.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/boot/dts/tegra-harmony.dts  |    1 +
>  arch/arm/boot/dts/tegra-seaboard.dts |    4 ++++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> index e581866..0e225b8 100644
> --- a/arch/arm/boot/dts/tegra-harmony.dts
> +++ b/arch/arm/boot/dts/tegra-harmony.dts
> @@ -66,5 +66,6 @@
>  		cd-gpios = <&gpio 58 0>; /* gpio PH2 */
>  		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
>  		power-gpios = <&gpio 70 0>; /* gpio PI6 */
> +		support-8bit;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
> index 64cedca..a72299b 100644
> --- a/arch/arm/boot/dts/tegra-seaboard.dts
> +++ b/arch/arm/boot/dts/tegra-seaboard.dts
> @@ -25,4 +25,8 @@
>  		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
>  		power-gpios = <&gpio 70 0>; /* gpio PI6 */
>  	};
> +
> +	sdhci at c8000600 {
> +		support-8bit;
> +	};
>  };
> -- 
> 1.7.0.4
> 
