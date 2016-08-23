From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 23 Aug 2016 18:35:30 +0100
Subject: [PATCH v3 09/12] arm64: dts: tegra: Add NVIDIA P3310 main board
 support
In-Reply-To: <20160819173233.13260-10-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-10-thierry.reding@gmail.com>
Message-ID: <9c123f91-d7ae-7cf1-f669-412aa350a0ca@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 19/08/16 18:32, Thierry Reding wrote:
> From: Joseph Lo <josephl@nvidia.com>
> 
> The NVIDIA P3310 is a processor module used in several reference designs
> that features a Tegra186 SoC, 8 GiB of LPDDR4 RAM, 32 GiB eMMC and other
> essentials such as ethernet, WiFi and a PMIC. It is typically connected
> to an I/O board (such as the P2597) that provides the connecters needed
> to hook it up to the outside world.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - fix compatible string
> 
>  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 34 ++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> new file mode 100644
> index 000000000000..dc07ea618378
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> @@ -0,0 +1,34 @@
> +#include "tegra186.dtsi"
> +
> +/ {
> +	model = "NVIDIA Tegra186 P3310 main Board";
> +	compatible = "nvidia,p3310", "nvidia,tegra186";
> +
> +	aliases {
> +		serial0 = &uarta;
> +	};
> +
> +	chosen {
> +		bootargs = "earlycon console=ttyS0,115200n8";

I don't think we need 'console' in the bootargs anymore because
stdout-path is enough (even for early console).

Cheers
Jon

-- 
nvpublic
