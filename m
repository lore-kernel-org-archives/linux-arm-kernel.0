From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 20 Sep 2011 11:42:29 -0600
Subject: [PATCH REPOST 1/2] arm/dt: Tegra: Update SDHCI nodes to match
	bindings
In-Reply-To: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
References: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110920174229.GH7781@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 10:46:25AM -0600, Stephen Warren wrote:
> The bindings were recently updated to have separate properties for each
> type of GPIO. Update the Device Tree source to match that.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Olof Johansson <olof@lixom.net>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> I'd previously sent these to Grant assuming they'd go in his dt/next branch,
> but perhaps these should go in through Arnd's arm-soc next/dt branch?

Yes, they should probably go via Arnd's tree.

g.

> 
>  arch/arm/boot/dts/tegra-harmony.dts  |   12 ++++++------
>  arch/arm/boot/dts/tegra-seaboard.dts |    6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> index 4c05334..e581866 100644
> --- a/arch/arm/boot/dts/tegra-harmony.dts
> +++ b/arch/arm/boot/dts/tegra-harmony.dts
> @@ -57,14 +57,14 @@
>  	};
>  
>  	sdhci at c8000200 {
> -		gpios = <&gpio 69 0>, /* cd, gpio PI5 */
> -			<&gpio 57 0>, /* wp, gpio PH1 */
> -			<&gpio 155 0>; /* power, gpio PT3 */
> +		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
> +		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
> +		power-gpios = <&gpio 155 0>; /* gpio PT3 */
>  	};
>  
>  	sdhci at c8000600 {
> -		gpios = <&gpio 58 0>, /* cd, gpio PH2 */
> -			<&gpio 59 0>, /* wp, gpio PH3 */
> -			<&gpio 70 0>; /* power, gpio PI6 */
> +		cd-gpios = <&gpio 58 0>; /* gpio PH2 */
> +		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
> +		power-gpios = <&gpio 70 0>; /* gpio PI6 */
>  	};
>  };
> diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
> index 1940cae..64cedca 100644
> --- a/arch/arm/boot/dts/tegra-seaboard.dts
> +++ b/arch/arm/boot/dts/tegra-seaboard.dts
> @@ -21,8 +21,8 @@
>  	};
>  
>  	sdhci at c8000400 {
> -		gpios = <&gpio 69 0>, /* cd, gpio PI5 */
> -			<&gpio 57 0>, /* wp, gpio PH1 */
> -			<&gpio 70 0>; /* power, gpio PI6 */
> +		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
> +		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
> +		power-gpios = <&gpio 70 0>; /* gpio PI6 */
>  	};
>  };
> -- 
> 1.7.0.4
> 
