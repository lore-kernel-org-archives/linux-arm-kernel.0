From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 17 Jul 2014 17:59:22 +0300
Subject: [PATCH 1/3] ARM: dts: keystone: add mdio devices entries
In-Reply-To: <1405609087-9128-1-git-send-email-grygorii.strashko@ti.com>
References: <1404911660-10047-2-git-send-email-grygorii.strashko@ti.com>
 <1405609087-9128-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <53C7E4CA.2090903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,
On 07/17/2014 05:58 PM, Grygorii Strashko wrote:
> The Keystone 2 has MDIO HW block which are compatible
> to Davinci SoCs:
> See "Gigabit Ethernet (GbE) Switch Subsystem"
>    See http://www.ti.com/lit/ug/sprugv9d/sprugv9d.pdf
>
> Hence, add corresponding DT entry for Keystone 2.

This is updated version of patch (missed v2 in subj).

>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>   arch/arm/boot/dts/keystone.dtsi |   11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index c1414cb..9e31fe7 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -266,5 +266,16 @@
>   			ranges = <0 0 0x30000000 0x10000000
>   				  1 0 0x21000A00 0x00000100>;
>   		};
> +
> +		mdio: mdio at 02090300 {
> +			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg		= <0x02090300 0x100>;
> +			status = "disabled";
> +			clocks = <&clkpa>;
> +			clock-names = "fck";
> +			bus_freq	= <2500000>;
> +		};
>   	};
>   };
>
