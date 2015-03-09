From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 9 Mar 2015 10:47:41 +0800
Subject: [PATCH v5 16/29] powerpc/pci: Use pci_scan_host_bridge() for
 simplicity
In-Reply-To: <CAL_JsqJqpbTThfm2yctHr-gyySyxsJT3HS8rxm6oY+ZYVT5vvQ@mail.gmail.com>
References: <1425634426-437-1-git-send-email-wangyijing@huawei.com>
 <1425634426-437-17-git-send-email-wangyijing@huawei.com>
 <CAL_JsqJqpbTThfm2yctHr-gyySyxsJT3HS8rxm6oY+ZYVT5vvQ@mail.gmail.com>
Message-ID: <54FD09CD.6010306@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/6 22:19, Rob Herring wrote:
> On Fri, Mar 6, 2015 at 3:33 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Now we could use pci_scan_host_bridge() to scan
>> pci buses, provide powerpc specific pci_host_bridge_ops.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: linuxppc-dev at lists.ozlabs.org
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  arch/powerpc/include/asm/machdep.h       |    2 +-
>>  arch/powerpc/kernel/pci-common.c         |   63 ++++++++++++++++++------------
>>  arch/powerpc/platforms/pseries/pci.c     |    8 ++--
>>  arch/powerpc/platforms/pseries/pseries.h |    2 +-
>>  4 files changed, 44 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>> index 8e7f2a8..b811d12 100644
>> --- a/arch/powerpc/include/asm/machdep.h
>> +++ b/arch/powerpc/include/asm/machdep.h
>> @@ -129,7 +129,7 @@ struct machdep_calls {
>>         void            (*pcibios_fixup)(void);
>>         int             (*pci_probe_mode)(struct pci_bus *);
>>         void            (*pci_irq_fixup)(struct pci_dev *dev);
>> -       int             (*pcibios_set_root_bus_speed)(struct pci_host_bridge
>> +       void            (*pcibios_set_root_bus_speed)(struct pci_host_bridge
>>                                 *bridge);
> 
> Shouldn't this be part of patch 15?

Hi Rob, I didn't merge this to patch 15 for building happy for patch 15.

> 
> Rob
> 
> .
> 


-- 
Thanks!
Yijing
