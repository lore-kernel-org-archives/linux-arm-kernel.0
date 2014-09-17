From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 17 Sep 2014 11:07:13 +0800
Subject: [RFC Part2 v1 02/21] genirq: Introduce helper functions to support
 stacked irq_chip
In-Reply-To: <alpine.DEB.2.10.1409161044330.4247@nanos>
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com>
 <1410444228-3134-3-git-send-email-jiang.liu@linux.intel.com>
 <alpine.DEB.2.10.1409161044330.4247@nanos>
Message-ID: <5418FAE1.4030008@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/9/17 1:45, Thomas Gleixner wrote:
> On Thu, 11 Sep 2014, Jiang Liu wrote:
>> +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>> +void irq_chip_ack_parent(struct irq_data *data)
>> +{
>> +	data = data->parent_data;
>> +	if (data && data->chip && data->chip->irq_ack)
>> +		data->chip->irq_ack(data);
> 
> Why is this restricted to a single parent level and does not go down
> the whole stack?
Hi Thomas,
	It happens to work on x86, and we want to achieve a bit
performance advantage by not walking down the whole stack.
If preferred, I will change it to walk the whole stack.
Regards!
Gerry

> 
> Thanks,
> 
> 	tglx
> 
