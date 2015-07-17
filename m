From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 17 Jul 2015 11:28:42 +0200
Subject: [PATCH V3 18/19] ARM: tegra: add GPU power supply to Jetson TK1 DT
In-Reply-To: <1436791197-32358-19-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-19-git-send-email-jonathanh@nvidia.com>
Message-ID: <20150717092841.GE3057@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 01:39:56PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh@nvidia.com>
> 
> Add power supply information which is board dependent for GK20A.
> 
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> index ce5961cd0b77..2b355957635c 100644
> --- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> +++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> @@ -1514,7 +1514,7 @@
>  					regulator-always-on;
>  				};
>  
> -				sd6 {
> +				vdd_gpu: sd6 {
>  					regulator-name = "+VDD_GPU_AP";
>  					regulator-min-microvolt = <650000>;
>  					regulator-max-microvolt = <1200000>;
> @@ -1635,6 +1635,10 @@
>  		};
>  	};
>  
> +	gpu-power-domain {
> +		vdd-supply = <&vdd_gpu>;
> +	};

This doesn't seem to match the path to the original node.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/6e42b0a0/attachment.sig>
