From: ralf@linux-mips.org (Ralf Baechle)
Date: Sat, 25 Oct 2014 15:04:28 +0200
Subject: [PATCH v3 16/27] Mips/MSI: Save msi chip in pci sysdata
In-Reply-To: <1413342435-7876-17-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-17-git-send-email-wangyijing@huawei.com>
Message-ID: <20141025130428.GD16738@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 11:07:04AM +0800, Yijing Wang wrote:

> +static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
> +{
> +	struct pci_controller *control = (struct pci_controller *)bus->sysdata;

bus->sysdata is void * so this cast is unnecessary.

  Ralf
