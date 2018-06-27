From: robh@kernel.org (Rob Herring)
Date: Wed, 27 Jun 2018 10:57:30 -0600
Subject: [PATCH 2/2] arm64: tegra: Add CPU nodes to Tegra194 device tree
In-Reply-To: <20180620122827.14165-2-mperttunen@nvidia.com>
References: <20180620122827.14165-1-mperttunen@nvidia.com>
 <20180620122827.14165-2-mperttunen@nvidia.com>
Message-ID: <20180627165730.GA15867@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 03:28:27PM +0300, Mikko Perttunen wrote:
> Add CPU and PSCI nodes to device tree. The Tegra194 SoC contains
> eight NVIDIA Carmel CPUs.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 40 +++++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 53 ++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> index ecb034177fc2..859ab5af17c1 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> @@ -229,6 +229,46 @@
>  		};
>  	};
>  
> +	cpus {
> +		cpu at 0 {
> +			enable-method = "psci";
> +		};

Kind of strange to have this separated out. I guess you have non-PSCI 
firmware too? In any case, unless things have changed, upstream is only 
supporting spin-table or PSCI for arm64. So please combine this with the 
rest of the cpu nodes.

Rob
