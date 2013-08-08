From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 09 Aug 2013 00:36:22 +0400
Subject: [PATCH v2 2/3] ARM: dt: t114 dalmore: add dt entry for nct1008
In-Reply-To: <1375944991-29182-3-git-send-email-wni@nvidia.com>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-3-git-send-email-wni@nvidia.com>
Message-ID: <52040146.7060703@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/08/2013 10:56 AM, Wei Ni wrote:

> Enable thermal sensor nct1008 for t114 dalmore.

> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>   arch/arm/boot/dts/tegra114-dalmore.dts |   10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> index b5a42f0..9d4d2b2 100644
> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
> @@ -738,6 +738,14 @@
>   			realtek,ldo1-en-gpios =
>   				<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
>   		};
> +
> +		nct1008 {

    ePAPR [1] says: "the name of a node should be somewhat generic, reflecting 
the function of the device and not its precise programming model". So I 
suggest "thermal"

> +			compatible = "onnn,nct1008";
> +			reg = <0x4c>;
> +			vdd-supply = <&palmas_ldo6_reg>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
> +		};
>   	};

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
