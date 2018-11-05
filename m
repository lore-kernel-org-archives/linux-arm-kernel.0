From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 5 Nov 2018 10:32:12 +0100
Subject: [PATCH] arm64: dts: zynqmp: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <20181024114540.5196-2-sudeep.holla@arm.com>
References: <20181024114540.5196-1-sudeep.holla@arm.com>
 <20181024114540.5196-2-sudeep.holla@arm.com>
Message-ID: <5f430204-9c97-0351-ff63-e64e8d42da69@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24. 10. 18 13:45, Sudeep Holla wrote:
> Most of the legacy "gpio-key,wakeup" boolean property is already
> replaced with "wakeup-source". However few occurrences of old property
> has popped up again, probably from the remnants in downstream trees.
> 
> This patch replaces the legacy properties with the unified
> "wakeup-source" property.
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index eb5e8bddb610..527b4d0f88e2 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -49,7 +49,7 @@
>  			label = "sw4";
>  			gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
>  			linux,code = <KEY_POWER>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			autorepeat;
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 25dd57485323..0397bf66b2e7 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -46,7 +46,7 @@
>  			label = "sw19";
>  			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
>  			linux,code = <KEY_DOWN>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			autorepeat;
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 259f21b0c001..7238f022a671 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -46,7 +46,7 @@
>  			label = "sw19";
>  			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
>  			linux,code = <KEY_DOWN>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			autorepeat;
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index a61b3cc6f4c9..fa055e718d4b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -46,7 +46,7 @@
>  			label = "sw19";
>  			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
>  			linux,code = <KEY_DOWN>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			autorepeat;
>  		};
>  	};
> --
> 2.17.1
> 
> 

Will be good to point to 700a38b27eefc which introduced but that's fine.

Applied.

Thanks,
Michal
