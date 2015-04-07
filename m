From: dja@axtens.net (Daniel Axtens)
Date: Tue, 07 Apr 2015 17:04:26 +1000
Subject: [PATCH v9 14/30] PCI: Introduce pci_host_bridge_ops to support
 host specific operations
In-Reply-To: <1428053164-28277-16-git-send-email-wangyijing@huawei.com>
References: <1428053164-28277-1-git-send-email-wangyijing@huawei.com>
 <1428053164-28277-16-git-send-email-wangyijing@huawei.com>
Message-ID: <1428390266.14169.1.camel@axtens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-04-03 at 17:25 +0800, Yijing Wang wrote:
> Now we have weak functions like pcibios_root_bridge_prepare()
> to setup pci host bridge, We could introduce pci_host_bridge_ops
> which contain host bridge specific ops to setup pci_host_bridge.
> Then host bridge driver could add pci_host_bridge_ops hooks
> intead of weak function to setup pci_host_bridge.
> This patch add following pci_host_bridge_ops hooks:
> 
> pci_host_bridge_ops {
> 	struct pci_ops *ops;
Trivial nit, but this is 'struct pci_ops *pci_ops' in the code below.

> +struct pci_host_bridge;
> +struct pci_host_bridge_ops {
> +	struct pci_ops *pci_ops;
> +	int (*prepare)(struct pci_host_bridge *host);
> +	void (*set_root_bus_speed)(struct pci_host_bridge *host);
> +	int (*scan_bus)(struct pci_host_bridge *host);
> +};
> +

Regards,
Daniel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 860 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150407/f16a0262/attachment.sig>
