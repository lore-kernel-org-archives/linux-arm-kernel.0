From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Sep 2014 09:19:20 +0200
Subject: [PATCH v2 03/22] MSI: Remove the redundant irq_set_chip_data()
In-Reply-To: <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
Message-ID: <20140925071919.GH12423@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 11:14:13AM +0800, Yijing Wang wrote:
> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
> use irq chip_data to save the msi_chip pointer. They
> already call irq_set_chip_data() in their own MSI irq map
> functions. So irq_set_chip_data() in arch_setup_msi_irq()
> is useless.

Again, I think this should be the other way around. If drivers do
something that's already handled by the core, then the duplicate code
should be dropped from the drivers.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/58aa4421/attachment-0001.sig>
