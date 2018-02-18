From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 18 Feb 2018 19:03:26 +0100
Subject: [PATCH v1 2/2] ARM: dts: tegra30: Add video decoder node
In-Reply-To: <6ac145a1259566f85c88bd29be9c8b3e44e53bcf.1518973069.git.digetx@gmail.com>
References: <cover.1518973069.git.digetx@gmail.com>
 <6ac145a1259566f85c88bd29be9c8b3e44e53bcf.1518973069.git.digetx@gmail.com>
Message-ID: <4cf77dcd-0921-dec2-e5cd-ed8b5dc2fb7c@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.02.2018 um 18:01 schrieb Dmitry Osipenko:
> Add device tree node for the Video Decoder Engine found on Tegra30 SoC's.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index 1fb0c421a9d8..8ae72ffe0048 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -17,6 +17,11 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0 0x40000000 0x40000>;
> +
> +		vde_pool: vde {
> +			reg = <0x400 0x3fc00>;

vde at 400 then, to avoid dtc warnings.

> +			pool;
> +		};
>  	};
>  
>  	pcie at 3000 {

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
