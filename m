From: davem@davemloft.net (David Miller)
Date: Wed, 16 Aug 2017 19:42:35 -0700 (PDT)
Subject: [PATCH net] PCI: fix the return value for the
 pci_find_pcie_root_port()
In-Reply-To: <1502936730-7368-1-git-send-email-dingtianhong@huawei.com>
References: <1502936730-7368-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <20170816.194235.391501463422735735.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>
Date: Thu, 17 Aug 2017 10:25:30 +0800

> The pci_find_pcie_root_port() would return NULL if the given
> dev is already a Root Port, it looks like unfriendly to the
> PCIe Root Port device, Thierry and Bjorn suggest to let this
> function return the given dev under this circumstances.
> 
> Fixes: 0e405232871d6 ("PCI: fix oops when try to find Root Port for a PCI device")
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>

Bjorn, please review and ACK so Linus doesn't rip my head off again
:-)

Thanks.
