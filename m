From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Jan 2015 09:10:49 -0800
Subject: linux-next: manual merge of the omap tree with the arm-soc tree
In-Reply-To: <20150120110947.1a92a416@canb.auug.org.au>
References: <20150120110947.1a92a416@canb.auug.org.au>
Message-ID: <20150120171048.GF7718@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Rothwell <sfr@canb.auug.org.au> [150119 16:12]:
> Hi Tony,
> 
> Today's linux-next merge of the omap tree got a conflict in
> arch/arm/boot/dts/Makefile between commit cb612390e546 ("ARM: dts: Only
> build dtb if associated Arch and/or SoC is enabled") from the arm-soc
> tree and commit ac7452cee743 ("ARM: dts: Add minimal support for
> dm8168-evm") from the omap tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Uhh why is cb612390e546 doing formatting changes all over the place?
That's a sure way to produce merge conflicts..

Anyways the conflict resolution looks good to me thanks.

Regards,

Tony
 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc arch/arm/boot/dts/Makefile
> index a240d2d07b38,a6ace4d57ea5..000000000000
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@@ -392,8 -348,8 +392,9 @@@ dtb-$(CONFIG_ARCH_OMAP3) += 
>   	omap3-sbc-t3730.dtb \
>   	omap3-thunder.dtb \
>   	omap3-zoom3.dtb
> + dtb-$(CONFIG_SOC_TI81XX) += dm8168-evm.dtb
>  -dtb-$(CONFIG_SOC_AM33XX) += am335x-base0033.dtb \
>  +dtb-$(CONFIG_SOC_AM33XX) += \
>  +	am335x-base0033.dtb \
>   	am335x-bone.dtb \
>   	am335x-boneblack.dtb \
>   	am335x-evm.dtb \
> @@@ -410,20 -365,17 +411,21 @@@ dtb-$(CONFIG_ARCH_OMAP4) += 
>   	omap4-sdp-es23plus.dtb \
>   	omap4-var-dvk-om44.dtb \
>   	omap4-var-stk-om44.dtb
>  -dtb-$(CONFIG_SOC_AM43XX) += am43x-epos-evm.dtb \
>  +dtb-$(CONFIG_SOC_AM43XX) += \
>  +	am43x-epos-evm.dtb \
>   	am437x-sk-evm.dtb \
> + 	am437x-idk-evm.dtb \
>   	am437x-gp-evm.dtb
>  -dtb-$(CONFIG_SOC_OMAP5) += omap5-cm-t54.dtb \
>  +dtb-$(CONFIG_SOC_OMAP5) += \
>  +	omap5-cm-t54.dtb \
>   	omap5-sbc-t54.dtb \
>   	omap5-uevm.dtb
>  -dtb-$(CONFIG_SOC_DRA7XX) += dra7-evm.dtb \
>  +dtb-$(CONFIG_SOC_DRA7XX) += \
>  +	dra7-evm.dtb \
>   	am57xx-beagle-x15.dtb \
>   	dra72-evm.dtb
>  -dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-d2-network.dtb \
>  +dtb-$(CONFIG_ARCH_ORION5X) += \
>  +	orion5x-lacie-d2-network.dtb \
>   	orion5x-lacie-ethernet-disk-mini-v2.dtb \
>   	orion5x-maxtor-shared-storage-2.dtb \
>   	orion5x-rd88f5182-nas.dtb
