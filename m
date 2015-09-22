From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Tue, 22 Sep 2015 22:35:13 +0530
Subject: [PATCH v9 3/6] PCI: designware: Add ARM64 support
In-Reply-To: <5600C285.5090603@hisilicon.com>
References: <1442321361-174300-1-git-send-email-wangzhou1@hisilicon.com>
 <1442321361-174300-4-git-send-email-wangzhou1@hisilicon.com>
 <5600C285.5090603@hisilicon.com>
Message-ID: <CAHM4w1mabn8SiE_oqWBbr1chrQTUPiUhc8fCsxJ0t=AyOZOadA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhou,

On Tue, Sep 22, 2015 at 8:22 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> On 2015/9/15 20:49, Zhou Wang wrote:
>> This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
>> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
>> move related operations to dw_pcie_host_init.
>>
>> This patch also try to use of_pci_get_host_bridge_resources for ARM32 and ARM64
>> according to the suggestion for Gabriele[1]
>>
>> This patch reverts commit f4c55c5a3f7f ("PCI: designware: Program ATU with
>> untranslated address") based on 1/6 in this series. we delete *_mod_base in
>> pcie-designware. This was discussed in [2]
>>
>> I have compiled the driver with multi_v7_defconfig. However, I don't have
>> ARM32 PCIe related board to do test. It will be appreciated if someone could
>> help to test it.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Tested-by: James Morse <james.morse@arm.com>
>> Tested-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> Tested-by: Minghuan Lian <Minghuan.Lian@freescale.com>

Sorry for delayed response. Since I moved from ST, I do not have any
test board having designware PCIe controller :(, and also I do
designware work only in my hobby time,  so it took time to understand
few modifications. Anyway, all modifications looks fine to me. So,

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

PS: Does someone know about a economical test board from any vendor
with designware PCIe IP?
