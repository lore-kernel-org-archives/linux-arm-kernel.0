From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Nov 2016 15:35:52 +0530
Subject: [PATCH 1/2] ARM: dts: da850: add the mstpri and ddrctl nodes
In-Reply-To: <1479144724-14231-2-git-send-email-bgolaszewski@baylibre.com>
References: <1479144724-14231-1-git-send-email-bgolaszewski@baylibre.com>
 <1479144724-14231-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <de22c568-22b8-7809-5506-cac23fad252d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 November 2016 11:02 PM, Bartosz Golaszewski wrote:
> Add the nodes for the MSTPRI configuration and DDR2/mDDR memory
> controller drivers to da850.dtsi.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 1bb1f6d..1635218 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -440,6 +440,11 @@
>  			interrupts = <52>;
>  			status = "disabled";
>  		};
> +
> +		mstpri: mstpri at 14110 {
> +			compatible = "ti,da850-mstpri";
> +			reg = <0x14110 0x0c>;
> +		};

Instead of adding the node to the end, can you place it above the
cfgchip node to keep it sorted by reg. We have not really followed that
in this file. May be we should have. But lets start with this.

>  	};
>  	aemif: aemif at 68000000 {
>  		compatible = "ti,da850-aemif";
> @@ -451,4 +456,8 @@
>  			  1 0 0x68000000 0x00008000>;
>  		status = "disabled";
>  	};
> +	ddrctl: ddrctl at b0000000 {
> +		compatible = "ti,da850-ddr-controller";
> +		reg = <0xb0000000 0xe8>;
> +	};

Can you name the node memory-controller at b0000000? Thats the generic name
suggested by ePAPR 1.1 for memory controllers.

I could not find any naming suggestions for the bus master priority
controller above, but based on the pattern used for other controllers,
may be it should be called priority-controller at 14110 instead of mstpri at 14110

Thanks,
Sekhar
