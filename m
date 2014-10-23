From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 22 Oct 2014 23:41:21 -0600
Subject: [PATCH v3 10/27] PCI/MSI: Remove useless bus->msi assignment
In-Reply-To: <1413342435-7876-11-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-11-git-send-email-wangyijing@huawei.com>
Message-ID: <20141023054121.GE11770@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 11:06:58AM +0800, Yijing Wang wrote:
> Now msi chip is saved in pci_sys_data in arm,
> we could clean the bus->msi assignment in
> pci core.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/probe.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index efa48dc..98bf4c3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -682,7 +682,6 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  
>  	child->parent = parent;
>  	child->ops = parent->ops;
> -	child->msi = parent->msi;

This needs an explanation of why ARM was the only arch to depend on this.

>  	child->sysdata = parent->sysdata;
>  	child->bus_flags = parent->bus_flags;
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
