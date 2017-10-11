From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Oct 2017 11:22:46 -0700
Subject: [PATCH 1/5] ARM: dts: dra7-evm-common: Enable relevant IPU and
 DSP MMU nodes
In-Reply-To: <20170821235158.4968-2-s-anna@ti.com>
References: <20170821235158.4968-1-s-anna@ti.com>
 <20170821235158.4968-2-s-anna@ti.com>
Message-ID: <20171011182246.GE4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [170821 16:52]:
> The MMU nodes for the remote processors IPU1, IPU2, DSP1 and
> DSP2 have all been enabled. All these nodes are relevant and
> valid for both the DRA7 EVM and DRA76 EVM boards, so are added
> in the dra7 common evm dtsi file.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/boot/dts/dra7-evm-common.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
> index 343e95f9a001..01a5d4e0b044 100644
> --- a/arch/arm/boot/dts/dra7-evm-common.dtsi
> +++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
> @@ -256,3 +256,27 @@
>  		status = "okay";
>  	};
>  };
> +
> +&mmu0_dsp1 {
> +	status = "okay";
> +};
> +
> +&mmu1_dsp1 {
> +	status = "okay";
> +};
> +
> +&mmu0_dsp2 {
> +	status = "okay";
> +};
> +
> +&mmu1_dsp2 {
> +	status = "okay";
> +};
> +
> +&mmu_ipu1 {
> +	status = "okay";
> +};
> +
> +&mmu_ipu2 {
> +	status = "okay";
> +};

This is getting quite silly.. The default is "okay" so just remove the useless
"disabled" from the common file and all these patches are no longer needed.

Regards,

Tony
