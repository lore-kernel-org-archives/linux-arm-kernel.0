From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 25 Mar 2015 09:22:02 +0800
Subject: [PATCH v8 24/30] PCI/tegra: Remove redundant tegra_pcie_scan_bus()
In-Reply-To: <20150324123139.GA11625@ulmo.nvidia.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
 <1427168064-8657-25-git-send-email-wangyijing@huawei.com>
 <20150324123139.GA11625@ulmo.nvidia.com>
Message-ID: <55120DBA.7080105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/24 20:31, Thierry Reding wrote:
> On Tue, Mar 24, 2015 at 11:34:18AM +0800, Yijing Wang wrote:
>> Now pci_scan_root_bus() is almost similar to
>> pci_create_root_bus() + pci_scan_child_bus().
>> So we could use common pci_scan_root_bus() in
>> pci_common_init_dev() to scan pci busses.
>> tegra_pcie_scan_bus() is redundant, remove it.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Thierry Reding <thierry.reding@gmail.com>
>> CC: linux-tegra at vger.kernel.org
>> ---
>>  drivers/pci/host/pci-tegra.c |   16 ----------------
>>  1 files changed, 0 insertions(+), 16 deletions(-)
> 
> Jetson TK1 still boots over NFS root via the onboard PCIe network card
> with this series applied, so:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Thanks!

> 


-- 
Thanks!
Yijing
