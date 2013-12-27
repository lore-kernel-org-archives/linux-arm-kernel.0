From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 27 Dec 2013 14:07:03 +0530
Subject: [PATCH V5 2/4] DRIVERS: IRQCHIP: CROSSBAR: Add support for
 Crossbar IP
In-Reply-To: <20131226200106.GA30559@saruman.home>
References: <1386066445-28245-1-git-send-email-r.sricharan@ti.com>
 <1386066445-28245-3-git-send-email-r.sricharan@ti.com>
 <20131226200106.GA30559@saruman.home>
Message-ID: <52BD3C2F.9010409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Friday 27 December 2013 01:31 AM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Dec 03, 2013 at 03:57:23PM +0530, Sricharan R wrote:
>> +static const struct of_device_id crossbar_match[] __initconst = {
>> +	{ .compatible = "ti,irq-crossbar" },
>> +	{}
>> +};
>> +
>> +int irqcrossbar_init(void)
>> +{
>> +	struct device_node *np;
>> +	np = of_find_matching_node(NULL, crossbar_match);
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	crossbar_of_init(np);
>> +	return 0;
>> +}
> 
> instead, please use IRQCHIP_DECLARE() then you won't need to expose this
> symbol to be used by arch/arm/ code.
> 

Crossbar node does not have a "interrupt-controller" property and
not a regular Interrupt controller. This was added in here
after all below discussions

 https://lkml.org/lkml/2013/9/18/540

So IRQCHIP_DECLARE() macro cannot be used here.

Regards,
 Sricharan
