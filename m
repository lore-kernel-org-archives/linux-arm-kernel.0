From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Fri, 14 Nov 2014 08:18:43 +0800
Subject: [Patch V1 3/6] genirq: Introduce msi_domain_{alloc|free}_irqs()
In-Reply-To: <5465134B.7070709@arm.com>
References: <1415879029-20098-1-git-send-email-jiang.liu@linux.intel.com>
 <1415879029-20098-4-git-send-email-jiang.liu@linux.intel.com>
 <5465134B.7070709@arm.com>
Message-ID: <54654A63.6040202@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/14 4:23, Marc Zyngier wrote:
> On 13/11/14 11:43, Jiang Liu wrote:
>> Introduce msi_domain_{alloc|free}_irqs() to alloc/free interrupts
>> from generic MSI irqdomain.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>  include/linux/msi.h |   35 ++++++++++++++++++++++++++++++
>>  kernel/irq/msi.c    |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 94 insertions(+)
>>
>> +/*
>> + * Default structure for MSI interrupt allocation.
>> + * Arch may overwrite it by define msi_alloc_info_t.
>> + */
>> +struct msi_alloc_info {
>> +	struct msi_desc *desc;
>> +	irq_hw_number_t hwirq;
>> +	long		scratchpad[NUM_MSI_ALLOC_SCRATCHPAD_REGS];
> 
> As much as I'm relieved to see a generic structure here, could
> scratchpad be slightly less awkward to use? Something like:
> 
> struct msi_alloc_info {
> 	[...]
> 	union	{
> 		unsigned long ul;
> 		void *ptr;
> 	} scratchpad[NUM_MSI_ALLOC_SCRATCHPAD_REGS];
> };
> 
> That would avoid some very ugly casting.
Great, will changed to this way in next version:)

> 
> Thanks,
> 
> 	M.
> 
