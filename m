From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Wed, 12 Aug 2015 21:12:01 +0530
Subject: [PATCH v6 2/6] ARM/PCI: remove align_resource in pci_sys_data
In-Reply-To: <55C44AF2.8040807@hisilicon.com>
References: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com>
 <1438848559-232109-3-git-send-email-wangzhou1@hisilicon.com>
 <55C44AF2.8040807@hisilicon.com>
Message-ID: <CAHM4w1=s_3A8L+XXyLCoxUphOed13CzShUiWwkK7vv8XJCBgjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 7, 2015 at 11:36 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> [+cc jingoohan1 at gmail.com]
>
> On 2015/8/6 16:09, Zhou Wang wrote:
>> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>>
>> This patch is needed in order to unify the PCIe designware framework for ARM and
>> ARM64 architectures. In the PCIe designware unification process we are calling
>> pci_create_root_bus() passing a "sysdata" parameter that is the same for both
>> ARM and ARM64 and is of type "struct pcie_port*". In the ARM case this will
>> cause a problem with the function pcibios_align_resource(); in fact this will
>> cast "dev->sysdata" to "struct pci_sys_data*", whereas designware had passed a
>> "struct pcie_port*" pointer.
>>
>> This patch solves the issue by removing "align_resource" from "pci_sys_data"
>> struct and defining a static global function pointer in "bios32.c"
>>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
