From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 9 Jul 2015 14:03:10 +0300
Subject: [RFC Patch V1 02/12] MIPS, PCI: Use for_pci_msi_entry() to access
 MSI device list
In-Reply-To: <1436428847-8886-3-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
 <1436428847-8886-3-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <559E54EE.7090504@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/9/2015 11:00 AM, Jiang Liu wrote:

> Use accessor for_pci_msi_entry() to access MSI device list, so we could

     Maybe for_each_pci_msi_entry()?

> easily move msi_list from struct pci_dev into struct device later.

> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>   arch/mips/pci/msi-octeon.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
> index cffaaf4aae3c..2a5bb849b10e 100644
> --- a/arch/mips/pci/msi-octeon.c
> +++ b/arch/mips/pci/msi-octeon.c
> @@ -200,7 +200,7 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>   	if (type == PCI_CAP_ID_MSI && nvec > 1)
>   		return 1;
>
> -	list_for_each_entry(entry, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(entry, dev) {
>   		ret = arch_setup_msi_irq(dev, entry);
>   		if (ret < 0)
>   			return ret;

WBR, Sergei
