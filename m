From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 2 Mar 2015 21:40:48 -0600
Subject: [PATCH v4 28/30] PCI: Export find_pci_host_bridge()
In-Reply-To: <1424938344-4017-29-git-send-email-wangyijing@huawei.com>
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
 <1424938344-4017-29-git-send-email-wangyijing@huawei.com>
Message-ID: <20150303034048.GM11978@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 04:12:22PM +0800, Yijing Wang wrote:
> Export find_pci_host_bridge().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/host-bridge.c |    2 +-
>  include/linux/pci.h       |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index 4a2baa2..51e24f8 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -104,7 +104,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
>  	return bus;
>  }
>  
> -static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)

Please name this "pci_find_host_bridge()" or similar so it looks like other
PCI functions.

>  {
>  	struct pci_bus *root_bus = find_pci_root_bus(bus);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2f29e95..6ac7926 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -426,6 +426,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>  struct pci_host_bridge *pci_create_host_bridge(
>  		struct device *parent, u32 dombus, struct list_head *resources, 
>  		void *sysdata, struct pci_host_bridge_ops *ops);
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus* bus);

I'm not sure this needs to be in include/linux/pci.h.  Wouldn't
drivers/pci/pci.h be enough?

>  /*
>   * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
>   * to P2P or CardBus bridge windows) go in a table.  Additional ones (for
> -- 
> 1.7.1
> 
