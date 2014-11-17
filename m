From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Mon, 17 Nov 2014 19:37:37 +0800
Subject: [Patch V3 6/9] genirq: Introduce msi_domain_{alloc|free}_irqs()
In-Reply-To: <alpine.DEB.2.11.1411171230090.3909@nanos>
References: <1416222202-28002-1-git-send-email-jiang.liu@linux.intel.com>
 <1416222202-28002-7-git-send-email-jiang.liu@linux.intel.com>
 <alpine.DEB.2.11.1411171230090.3909@nanos>
Message-ID: <5469DE01.6030308@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/17 19:30, Thomas Gleixner wrote:
> On Mon, 17 Nov 2014, Jiang Liu wrote:
>> +
>> +/*
>> + * Default structure for MSI interrupt allocation.
>> + * Arch may overwrite it by defining msi_alloc_info_t.
>> + */
>> +struct msi_alloc_info {
>> +	struct msi_desc			*desc;
>> +	irq_hw_number_t			hwirq;
>> +	union {
>> +		unsigned long		ul;
>> +		void			*ptr;
>> +	} scratchpad[NUM_MSI_ALLOC_SCRATCHPAD_REGS];
>> +};
>> +
>> +#ifndef msi_alloc_info_t
>> +typedef struct msi_alloc_info msi_alloc_info_t;
>> +#endif
> 
> Hmm. Do we really need that?
Hi Thomas,
	Do you mean msi_alloc_info_t? It acts as a flag
to use common struct msi_alloc_info or architecture specific
data structures. For most architecture, they will use the default
struct msi_alloc_info. But for x86, it will use struct irq_alloc_info.
Regards!
Gerry
