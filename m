From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Sep 2014 09:37:01 +0200
Subject: [PATCH v2 15/22] MIPS/Xlr/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
In-Reply-To: <1411614872-4009-16-git-send-email-wangyijing@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-16-git-send-email-wangyijing@huawei.com>
Message-ID: <20140925073700.GL12423@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 11:14:25AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
[...]
> @@ -214,11 +214,11 @@ static int get_irq_vector(const struct pci_dev *dev)
>  }
>  
>  #ifdef CONFIG_PCI_MSI
> -void arch_teardown_msi_irq(unsigned int irq)
> +void xlr_teardown_msi_irq(unsigned int irq)
>  {
>  }
>  
> -int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +int xlr_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)

Can both of these now be static?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/9b4b49ed/attachment-0001.sig>
