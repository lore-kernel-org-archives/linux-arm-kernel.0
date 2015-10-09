From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 09 Oct 2015 15:31:12 +0100
Subject: [PATCH 01/16] irqdomain: Use an accessor for the of_node field
In-Reply-To: <alpine.DEB.2.11.1510091623090.6097@nanos>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
 <1444152989-31726-2-git-send-email-marc.zyngier@arm.com>
 <alpine.DEB.2.11.1510091623090.6097@nanos>
Message-ID: <5617CFB0.8090703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/15 15:24, Thomas Gleixner wrote:
> On Tue, 6 Oct 2015, Marc Zyngier wrote:
>> index d3ca792..f644fdb 100644
>> --- a/include/linux/irqdomain.h
>> +++ b/include/linux/irqdomain.h
>> @@ -161,6 +161,11 @@ enum {
>>  	IRQ_DOMAIN_FLAG_NONCORE		= (1 << 16),
>>  };
>>  
>> +static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
>> +{
>> +	return d->of_node;
>> +}
>> +
> 
> Can you please make that a seperate patch, which I can expedite to
> Linus? That way we can fix stuff which shows up in next as well.

Just this one hunk? Sure. Coming up!

	M.
-- 
Jazz is not dead. It just smells funny...
