From: nm@ti.com (Nishanth Menon)
Date: Fri, 21 Sep 2018 14:42:38 -0500
Subject: [RFC PATCH 36/40] arm64: dts: k3-am6: Add
 "socionext,synquacer-pre-its" property to gic_its
In-Reply-To: <20180921102155.22839-37-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
 <20180921102155.22839-37-kishon@ti.com>
Message-ID: <20180921194238.mhckqlsztk2eduwp@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:21-20180921, Kishon Vijay Abraham I wrote:
> GIC_ITS used in AM65x platform has the same configuration as that of
> GIC_ITS used in Socionext SoCs. Add "socionext,synquacer-pre-its"
> property to get PCI MSI working.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index adcd6341e40c..2df4acb198bd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -24,6 +24,7 @@
>  		gic_its: gic-its at 18200000 {
>  			compatible = "arm,gic-v3-its";
>  			reg = <0x00 0x01820000 0x00 0x10000>;
> +			socionext,synquacer-pre-its = <0x1000000 0x400000>;
>  			msi-controller;
>  			#msi-cells = <1>;
>  		};
> -- 
> 2.17.1
> 


Please post the DTS series separately. This specific patch is a GIC ITS
patch, and does'nt need to depend on rest of the PCI series. Also looks
like you missed the v4.20-rc1 bandwagon.

 
-- 
Regards,
Nishanth Menon
