From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 05 Dec 2014 10:10:29 +0000
Subject: [PATCH v3 09/13] irqchip: GICv3: ITS: MSI support
In-Reply-To: <CALRxmdAULDXqx5oNUGQx9y2oUegULKO7=gWQWMRkFOzFo9XS8A@mail.gmail.com>
References: <1416839720-18400-1-git-send-email-marc.zyngier@arm.com>	<1416839720-18400-10-git-send-email-marc.zyngier@arm.com>
 <CALRxmdAULDXqx5oNUGQx9y2oUegULKO7=gWQWMRkFOzFo9XS8A@mail.gmail.com>
Message-ID: <54818495.5010700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stuart,

On 04/12/14 21:52, Stuart Yoder wrote:
> On Mon, Nov 24, 2014 at 8:35 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> +/*
>> + * We need a value to serve as a irq-type for LPIs. Choose one that will
>> + * hopefully pique the interest of the reviewer.
>> + */
>> +#define GIC_IRQ_TYPE_LPI               0xa110c8ed
> 
> Ok, my interest is piqued.  Why this value?

See the xlate function in the main GICv3 driver.

We need something to indicate that we want it to allocate an LPI, but
this function is mostly DT-specific, and we don't have an LPI type in
the binding just yet (I've purposely pushed back on it until we have a
clear idea of where we want to take LPIs).

So this value is just a made up thing that is unlikely to ever find its
place in a DT binding.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
