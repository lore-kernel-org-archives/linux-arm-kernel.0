From: david@lechnology.com (David Lechner)
Date: Tue, 22 Nov 2016 16:23:23 -0600
Subject: [PATCH v2] ARM: dts: da850: add the mstpri and ddrctl nodes
In-Reply-To: <1479207611-18028-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479207611-18028-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <a39b9276-865b-6382-574e-a5ef040a452f@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2016 05:00 AM, Bartosz Golaszewski wrote:
> Add the nodes for the MSTPRI configuration and DDR2/mDDR memory
> controller drivers to da850.dtsi.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> v1 -> v2:
> - moved the priority controller node above the cfgchip node
> - renamed added nodes to better reflect their purpose
>
>  arch/arm/boot/dts/da850.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 1bb1f6d..412eec6 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -210,6 +210,10 @@
>  			};
>
>  		};
> +		prictrl: priority-controller at 14110 {
> +			compatible = "ti,da850-mstpri";
> +			reg = <0x14110 0x0c>;

I think we should add status = "disabled"; here and let boards opt in.

> +		};
>  		cfgchip: chip-controller at 1417c {
>  			compatible = "ti,da830-cfgchip", "syscon", "simple-mfd";
>  			reg = <0x1417c 0x14>;
> @@ -451,4 +455,8 @@
>  			  1 0 0x68000000 0x00008000>;
>  		status = "disabled";
>  	};
> +	memctrl: memory-controller at b0000000 {
> +		compatible = "ti,da850-ddr-controller";
> +		reg = <0xb0000000 0xe8>;

same here. status = "disabled";

> +	};
>  };
>
