From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Jul 2017 13:38:25 +0200
Subject: [PATCH v2] arm64: dts: marvell: mark the cp110 crypto engine as
 dma coherent
In-Reply-To: <20170719090426.10228-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Wed, 19 Jul 2017 11:04:26 +0200")
References: <20170719090426.10228-1-antoine.tenart@free-electrons.com>
Message-ID: <87d18w7j2m.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On mer., juil. 19 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> The crypto engines found on the cp110 master and slave are dma coherent.
> This patch adds the relevant property to their dt nodes.
>
> Cc: stable at vger.kernel.org # v4.12+
> Fixes: 973020fd9498 ("arm64: marvell: dts: add crypto engine description for 7k/8k")
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/fixes

Thanks,

Gregory
> ---
>
> Since v1: added the 'Fixes:' and 'Cc: stable' tags.
>
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 1 +
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 726528ce54e9..4c68605675a8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -270,6 +270,7 @@
>  				interrupt-names = "mem", "ring0", "ring1",
>  				"ring2", "ring3", "eip";
>  				clocks = <&cpm_clk 1 26>;
> +				dma-coherent;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 95f8e5f607f6..0dbb59811d00 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -261,6 +261,7 @@
>  				interrupt-names = "mem", "ring0", "ring1",
>  						  "ring2", "ring3", "eip";
>  				clocks = <&cps_clk 1 26>;
> +				dma-coherent;
>  				/*
>  				 * The cryptographic engine found on the cp110
>  				 * master is enabled by default at the SoC
> -- 
> 2.13.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
