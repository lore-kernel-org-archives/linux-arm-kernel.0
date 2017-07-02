From: helgaas@kernel.org (Bjorn Helgaas)
Date: Sun, 2 Jul 2017 16:49:32 -0500
Subject: [PATCH] PCI: xilinx: make of_device_ids const.
In-Reply-To: <5e1534021d712fa92cc0178313daeeb22e34798d.1497937235.git.arvind.yadav.cs@gmail.com>
References: <5e1534021d712fa92cc0178313daeeb22e34798d.1497937235.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170702214932.GI18324@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 11:17:48AM +0530, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>     195	    600	      0	    795	    31b	drivers/pci/host/pcie-xilinx.o
> 
> File size after constify xilinx_pcie_of_match:
>    text	   data	    bss	    dec	    hex	filename
>     595	    184	      0	    779	    30b	drivers/pci/host/pcie-xilinx.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to pci/host-xilinx for v4.13, thanks!

> ---
>  drivers/pci/host/pcie-xilinx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 2fe2df5..b621cb5 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -696,7 +696,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static struct of_device_id xilinx_pcie_of_match[] = {
> +static const struct of_device_id xilinx_pcie_of_match[] = {
>  	{ .compatible = "xlnx,axi-pcie-host-1.00.a", },
>  	{}
>  };
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
