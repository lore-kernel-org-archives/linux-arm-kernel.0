From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 26 Sep 2014 10:13:21 +0800
Subject: [PATCH v2 14/22] MIPS/Xlp/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
In-Reply-To: <20140925073608.GK12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-15-git-send-email-wangyijing@huawei.com>
 <20140925073608.GK12423@ulmo>
Message-ID: <5424CBC1.8080702@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/25 15:36, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:24AM +0800, Yijing Wang wrote:
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Nit: s/irq/IRQ/ in the above.
> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  arch/mips/pci/msi-xlp.c |   14 ++++++++++++--
>>  1 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
>> index e469dc7..6b791ef 100644
>> --- a/arch/mips/pci/msi-xlp.c
>> +++ b/arch/mips/pci/msi-xlp.c
>> @@ -245,7 +245,7 @@ static struct irq_chip xlp_msix_chip = {
>>  	.irq_unmask	= unmask_msi_irq,
>>  };
>>  
>> -void arch_teardown_msi_irq(unsigned int irq)
>> +void xlp_teardown_msi_irq(unsigned int irq)
> 
> Should this not be static now as well?

Yes, Will update.

> 
> Thierry
> 


-- 
Thanks!
Yijing
