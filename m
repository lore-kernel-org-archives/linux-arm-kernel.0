From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 10:36:07 +0800
Subject: [PATCH 2/2] arm64: dts: updated sata node on ls1046a dts
In-Reply-To: <1479369560-9188-2-git-send-email-yuantian.tang@nxp.com>
References: <1479369560-9188-1-git-send-email-yuantian.tang@nxp.com>
 <1479369560-9188-2-git-send-email-yuantian.tang@nxp.com>
Message-ID: <20161230023606.GJ6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 03:59:20PM +0800, yuantian.tang at nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> On ls1046a soc, sata ecc should be disabled. So added sata ecc

disabled or enabled?

Shawn

> register address so that driver can get this information.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 38806ca..88aaaf1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -507,7 +507,9 @@
>  
>  		sata: sata at 3200000 {
>  			compatible = "fsl,ls1046a-ahci";
> -			reg = <0x0 0x3200000 0x0 0x10000>;
> +			reg = <0x0 0x3200000 0x0 0x10000>,
> +			    <0x0 0x20140520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
>  			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clockgen 4 1>;
>  		};
> -- 
> 2.1.0.27.g96db324
> 
