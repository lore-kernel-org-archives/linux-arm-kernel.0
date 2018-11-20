From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 20 Nov 2018 13:04:25 +0000
Subject: [PATCH] PCI: dwc: layerscape: constify driver data
In-Reply-To: <20181119100022.27501-1-stefan@agner.ch>
References: <20181119100022.27501-1-stefan@agner.ch>
Message-ID: <20181120130425.GB23472@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 11:00:22AM +0100, Stefan Agner wrote:
> Constify driver data since they don't get changed at runtime.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied to pci/dwc for v4.21.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 3724d3ef7008..905a0ab0e6fa 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -222,12 +222,12 @@ static const struct dw_pcie_ops dw_ls_pcie_ops = {
>  	.link_up = ls_pcie_link_up,
>  };
>  
> -static struct ls_pcie_drvdata ls1021_drvdata = {
> +static const struct ls_pcie_drvdata ls1021_drvdata = {
>  	.ops = &ls1021_pcie_host_ops,
>  	.dw_pcie_ops = &dw_ls1021_pcie_ops,
>  };
>  
> -static struct ls_pcie_drvdata ls1043_drvdata = {
> +static const struct ls_pcie_drvdata ls1043_drvdata = {
>  	.lut_offset = 0x10000,
>  	.ltssm_shift = 24,
>  	.lut_dbg = 0x7fc,
> @@ -235,7 +235,7 @@ static struct ls_pcie_drvdata ls1043_drvdata = {
>  	.dw_pcie_ops = &dw_ls_pcie_ops,
>  };
>  
> -static struct ls_pcie_drvdata ls1046_drvdata = {
> +static const struct ls_pcie_drvdata ls1046_drvdata = {
>  	.lut_offset = 0x80000,
>  	.ltssm_shift = 24,
>  	.lut_dbg = 0x407fc,
> @@ -243,7 +243,7 @@ static struct ls_pcie_drvdata ls1046_drvdata = {
>  	.dw_pcie_ops = &dw_ls_pcie_ops,
>  };
>  
> -static struct ls_pcie_drvdata ls2080_drvdata = {
> +static const struct ls_pcie_drvdata ls2080_drvdata = {
>  	.lut_offset = 0x80000,
>  	.ltssm_shift = 0,
>  	.lut_dbg = 0x7fc,
> @@ -251,7 +251,7 @@ static struct ls_pcie_drvdata ls2080_drvdata = {
>  	.dw_pcie_ops = &dw_ls_pcie_ops,
>  };
>  
> -static struct ls_pcie_drvdata ls2088_drvdata = {
> +static const struct ls_pcie_drvdata ls2088_drvdata = {
>  	.lut_offset = 0x80000,
>  	.ltssm_shift = 0,
>  	.lut_dbg = 0x407fc,
> -- 
> 2.19.1
> 
