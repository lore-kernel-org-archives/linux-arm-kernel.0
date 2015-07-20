From: nm@ti.com (Nishanth Menon)
Date: Mon, 20 Jul 2015 15:58:13 -0500
Subject: [PATCH] ARM: dts: omap5-uevm: Add Palmas power button support
In-Reply-To: <1437426451-27372-1-git-send-email-aparnab@ti.com>
References: <omap5uevm_palmas>
 <1437426451-27372-1-git-send-email-aparnab@ti.com>
Message-ID: <55AD60E5.60301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2015 04:07 PM, Aparna Balasubramanian wrote:
> Palmas on OMAP5uevm has support for power button, so enable it.
> 
> Signed-off-by: Aparna Balasubramanian <aparnab@ti.com>
> ---
> 
> Based on kernel tag 4.2.0-rc1 and test result log is at
> http://pastebin.ubuntu.com/11910178/
> 
>  arch/arm/boot/dts/omap5-uevm.dts |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 275618f..3cc8f35 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -510,6 +510,13 @@
>  				};
>  			};
>  		};
> +
> +		palmas_power_button: palmas_power_button {
> +			compatible = "ti,palmas-pwrbutton";
> +			interrupt-parent = <&palmas>;
> +			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +			wakeup-source;
> +		};
>  	};
>  
>  	twl6040: twl at 4b {
> 

Tested (with evtest) and verified on v4.2-rc3

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
