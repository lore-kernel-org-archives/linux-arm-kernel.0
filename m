From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 12 Jun 2013 12:33:45 +0200
Subject: [PATCH v2 2/8] PCI: Add registry of MSI chips
In-Reply-To: <1370536888-8871-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370536888-8871-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130612103344.GD30841@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 06:41:22PM +0200, Thomas Petazzoni wrote:
[...]
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 4633529..a1a6084 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -61,6 +61,8 @@ int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
>  struct msi_chip {
>  	struct module *owner;
>  	struct device *dev;
> +	struct device_node *of_node;

Shouldn't we be reusing the dev.of_node field to look this information
up? On Tegra we do register the MSI chip and set the dev member to the
PCIe host bridge device. Can't the same thing be done for the Armada?

I assume that the MSI controller provider will be instantiated from the
device tree and hence there will already be a struct platform_device and
therefore also a struct device associated with it which should have the
of_node field set to the correct value automatically.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130612/674c4214/attachment.sig>
