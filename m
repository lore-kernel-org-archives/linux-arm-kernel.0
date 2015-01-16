From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 10:44:29 +0100
Subject: [PATCH 27/28] PCI: Remove platform specific pci_domain_nr()
In-Reply-To: <1421372666-12288-28-git-send-email-wangyijing@huawei.com>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
 <1421372666-12288-28-git-send-email-wangyijing@huawei.com>
Message-ID: <1561857.t9qV46uRjC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 January 2015 09:44:25 Yijing Wang wrote:
> 
> +int pci_domain_nr(struct pci_bus *bus)
> +{
> +       struct pci_host_bridge *host = find_pci_host_bridge(bus);
> +
> +       return host->domain;
> +}
> +EXPORT_SYMBOL_GPL(pci_domain_nr);
> +

Since most of the existing functions are exported as EXPORT_SYMBOL
rather than EXPORT_SYMBOL_GPL, I think the new version should do
the same.

	Arnd
