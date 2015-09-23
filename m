From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Wed, 23 Sep 2015 11:25:56 +0800
Subject: [PATCH v9 3/6] PCI: designware: Add ARM64 support
In-Reply-To: <CAHM4w1mabn8SiE_oqWBbr1chrQTUPiUhc8fCsxJ0t=AyOZOadA@mail.gmail.com>
References: <1442321361-174300-1-git-send-email-wangzhou1@hisilicon.com>
 <1442321361-174300-4-git-send-email-wangzhou1@hisilicon.com>
 <5600C285.5090603@hisilicon.com>
 <CAHM4w1mabn8SiE_oqWBbr1chrQTUPiUhc8fCsxJ0t=AyOZOadA@mail.gmail.com>
Message-ID: <56021BC4.9030000@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/9/23 1:05, Pratyush Anand wrote:
> Hi Zhou,
> 
> On Tue, Sep 22, 2015 at 8:22 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>> On 2015/9/15 20:49, Zhou Wang wrote:
>>> This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
>>> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
>>> move related operations to dw_pcie_host_init.
>>>
>>> This patch also try to use of_pci_get_host_bridge_resources for ARM32 and ARM64
>>> according to the suggestion for Gabriele[1]
>>>
>>> This patch reverts commit f4c55c5a3f7f ("PCI: designware: Program ATU with
>>> untranslated address") based on 1/6 in this series. we delete *_mod_base in
>>> pcie-designware. This was discussed in [2]
>>>
>>> I have compiled the driver with multi_v7_defconfig. However, I don't have
>>> ARM32 PCIe related board to do test. It will be appreciated if someone could
>>> help to test it.
>>>
>>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Tested-by: James Morse <james.morse@arm.com>
>>> Tested-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>>> Tested-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> Sorry for delayed response. Since I moved from ST, I do not have any
> test board having designware PCIe controller :(, and also I do
> designware work only in my hobby time,  so it took time to understand
> few modifications. Anyway, all modifications looks fine to me. So,
> 
> Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

Hi Pratyush,

Many thanks for your reviewing :)

Best Regards,
Zhou

> 
> PS: Does someone know about a economical test board from any vendor
> with designware PCIe IP?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 
