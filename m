From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 23 Oct 2014 14:40:50 +0800
Subject: [PATCH v3 10/27] PCI/MSI: Remove useless bus->msi assignment
In-Reply-To: <20141023054121.GE11770@google.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-11-git-send-email-wangyijing@huawei.com>
 <20141023054121.GE11770@google.com>
Message-ID: <5448A2F2.7060001@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/10/23 13:41, Bjorn Helgaas wrote:
> On Wed, Oct 15, 2014 at 11:06:58AM +0800, Yijing Wang wrote:
>> Now msi chip is saved in pci_sys_data in arm,
>> we could clean the bus->msi assignment in
>> pci core.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Thierry Reding <thierry.reding@gmail.com>
>> CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  drivers/pci/probe.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index efa48dc..98bf4c3 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -682,7 +682,6 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>>  
>>  	child->parent = parent;
>>  	child->ops = parent->ops;
>> -	child->msi = parent->msi;
> 
> This needs an explanation of why ARM was the only arch to depend on this.

OK, will add explanation in next version.

> 
>>  	child->sysdata = parent->sysdata;
>>  	child->bus_flags = parent->bus_flags;
>>  
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing
