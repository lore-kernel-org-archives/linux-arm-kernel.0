From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jun 2017 18:27:17 +0200
Subject: [PATCH v2 3/3] arm64: dts: marvell: add a comment on the cp110
 slave node status
In-Reply-To: <20170615121004.32257-3-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Thu, 15 Jun 2017 14:10:04 +0200")
References: <20170615121004.32257-1-antoine.tenart@free-electrons.com>
 <20170615121004.32257-3-antoine.tenart@free-electrons.com>
Message-ID: <8760fx6wt6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On jeu., juin 15 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> The cryptographic engine found on the cp110 slave is disabled by default
> because of some known limitations. Add a comment to explain why it is
> disabled by default.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>


Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 7e98c155cc6a..385ac30d6012 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -234,6 +234,13 @@
>  						  "ring2", "ring3", "eip";
>  				clocks = <&cps_syscon0 1 26>;
>  				dma-mask = <0xff 0xffffffff>;
> +				/*
> +				 * The cryptographic engine found on the cp110
> +				 * master is enabled by default at the SoC
> +				 * level. Because it is not possible as of now
> +				 * to enable two cryptographic engines in
> +				 * parallel, disable this one by default.
> +				 */
>  				status = "disabled";
>  			};
>  		};
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
