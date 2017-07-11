From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 11 Jul 2017 11:50:09 +0300
Subject: [PATCH] ARM: tegra: Register host1x node with iommu binding on
 tegra124
In-Reply-To: <20170709163614.6746-1-contact@paulk.fr>
References: <20170709163614.6746-1-contact@paulk.fr>
Message-ID: <1499763009.1340.11.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-07-09 at 19:36 +0300, Paul Kocialkowski wrote:
> This registers the host1x node with the SMMU (as HC swgroup) to allow
> the host1x code to attach to it. It avoid failing the probe sequence,
> which resulted in the tegra drm driver not probing and thus nothing
> being displayed on-screen.

Fixes: 404bfb78daf3 ("gpu: host1x: Add IOMMU support")

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/tegra124.dtsi
> b/arch/arm/boot/dts/tegra124.dtsi
> index 187a36c6d0fc..b3b89befffeb 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -85,6 +85,7 @@
>  		clocks = <&tegra_car TEGRA124_CLK_HOST1X>;
>  		resets = <&tegra_car 28>;
>  		reset-names = "host1x";
> +		iommus = <&mc TEGRA_SWGROUP_HC>;
>  
>  		#address-cells = <2>;
>  		#size-cells = <2>;
-- 
Paul Kocialkowski,

developer of free digital technology and hardware support

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
