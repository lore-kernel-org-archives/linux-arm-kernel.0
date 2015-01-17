From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 17 Jan 2015 19:39:46 +0300
Subject: [PATCH 23/28] PCI/designware: Use pci_scan_root_bus() for
 simplicity
In-Reply-To: <1421372666-12288-24-git-send-email-wangyijing@huawei.com>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
 <1421372666-12288-24-git-send-email-wangyijing@huawei.com>
Message-ID: <54BA9052.9080904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/16/2015 4:44 AM, Yijing Wang wrote:

> Use pci_scan_root_bus() instead of pci_create_root_bus() +
> pci_scan_child_bus() for simplicity.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>   drivers/pci/host/pcie-designware.c |    4 +---
>   1 files changed, 1 insertions(+), 3 deletions(-)

> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index eef3111..d37fe27 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -725,13 +725,11 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>   	struct pcie_port *pp = sys_to_pcie(sys);
>
>   	pp->root_bus_nr = sys->busnr;
> -	bus = pci_create_root_bus(pp->dev, sys->busnr,
> +	bus = pci_scan_root_bus(pp->dev, sys->busnr,
>   				  &dw_pcie_ops, sys, &sys->resources);

    Please realign this line, so that it still starts under 'pp'.

WBR, Sergei
