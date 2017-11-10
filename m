From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 10 Nov 2017 11:52:21 +0530
Subject: [PATCHv4 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
In-Reply-To: <20171110034847.17891-2-xiaowei.bao@nxp.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
 <20171110034847.17891-2-xiaowei.bao@nxp.com>
Message-ID: <20b8f1d2-f817-469f-afbf-66f25d6f8c46@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bao,

On Friday 10 November 2017 09:18 AM, Bao Xiaowei wrote:
> Add the property of inbound and outbound windows number for ep
> driver.
> 
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
> ---
>  v2:
>  - no change
>  v3:
>  - modify the commit message
>  v4:
>  - no change
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

$subject should start with something like
arm64: dts: ls1046a: **
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 06b5e12d04d8..f8332669663c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -674,6 +674,8 @@
>  			device_type = "pci";
>  			dma-coherent;
>  			num-lanes = <4>;
> +			num-ib-windows = <6>;
> +			num-ob-windows = <6>;

EP specific properties shouldn't be added in RC dt node. Ideally you should
have a separate dt node for RC and EP.

Thanks
Kishon
