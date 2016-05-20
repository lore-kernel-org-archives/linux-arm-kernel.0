From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 20 May 2016 20:55:56 +0800
Subject: [PATCH] arm64: dts: rockchip: fixes the gic400 2nd region size
 for rk3368
In-Reply-To: <1463582510-29156-1-git-send-email-wxt@rock-chips.com>
References: <1463582510-29156-1-git-send-email-wxt@rock-chips.com>
Message-ID: <61133267-f903-b580-7737-b77610392cde@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/5/18 22:41, Caesar Wang ??:
> The 2nd additional region is the GIC virtual cpu interface register
> base and size.
>
> As the gic400 of rk3368 says, the cpu interface register map as below
>
> :
>
> -0x0000 GICC_CTRL
> .
> .
> .
> -0x00fc GICC_IIDR
> -0x1000 GICC_IDR
>
> Obviously, the region size should be greater than 0x1000.
> So we should make sure to include the GICC_IDR since the kernel will access
> it in some cases.
>

yes, address range for GICC_* should be from 0x2000 to 0x3fff according
to gic400 memory map Table 3-1.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
>
> ---
>
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index 8b4a7c9..080203e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -670,7 +670,7 @@
>  		#address-cells = <0>;
>
>  		reg = <0x0 0xffb71000 0x0 0x1000>,
> -		      <0x0 0xffb72000 0x0 0x1000>,
> +		      <0x0 0xffb72000 0x0 0x2000>,
>  		      <0x0 0xffb74000 0x0 0x2000>,
>  		      <0x0 0xffb76000 0x0 0x2000>;
>  		interrupts = <GIC_PPI 9
>


-- 
Best Regards
Shawn Lin
