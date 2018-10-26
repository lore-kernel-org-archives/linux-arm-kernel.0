From: xiaowei.bao@nxp.com (Xiaowei Bao)
Date: Fri, 26 Oct 2018 03:45:43 +0000
Subject: [PATCH 3/6] PCI: layerscape: Add the EP mode support
In-Reply-To: <20181025215246.GA14861@bogus>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-3-xiaowei.bao@nxp.com> <20181025215246.GA14861@bogus>
Message-ID: <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Rob Herring <robh@kernel.org> 
Sent: 2018?10?26? 5:53
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Cc: bhelgaas at google.com; mark.rutland at arm.com; shawnguo at kernel.org; Leo Li <leoyang.li@nxp.com>; kishon at ti.com; lorenzo.pieralisi at arm.com; arnd at arndb.de; gregkh at linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; kstewart at linuxfoundation.org; cyrille.pitchen at free-electrons.com; pombredanne at nexb.com; shawn.lin at rock-chips.com; niklas.cassel at axis.com; linux-pci at vger.kernel.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org
Subject: Re: [PATCH 3/6] PCI: layerscape: Add the EP mode support

On Thu, Oct 25, 2018 at 07:08:58PM +0800, Xiaowei Bao wrote:
> Add the EP mode support.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 66df1e8..d3d7be1 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -13,12 +13,15 @@ information.
>  
>  Required properties:
>  - compatible: should contain the platform identifier such as:
> +  RC mode:
>          "fsl,ls1021a-pcie", "snps,dw-pcie"
>          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
>          "fsl,ls2088a-pcie"
>          "fsl,ls1088a-pcie"
>          "fsl,ls1046a-pcie"
>          "fsl,ls1012a-pcie"
> +  EP mode:
> +        "fsl,ls-pcie-ep"

You need SoC specific compatibles for the same reasons as the RC.
[Xiaowei Bao] I want to contains all layerscape platform use one compatible if the PCIe controller work in EP mode.

Rob
