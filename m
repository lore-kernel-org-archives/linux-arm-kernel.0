From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 9 Jan 2012 10:56:24 +0100
Subject: [PATCH v2 2/5] ARM: OMAP2/3: intc: Add irqdomain support
In-Reply-To: <20120106212230.GB7457@ponder.secretlab.ca>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
 <1324388398-2683-3-git-send-email-b-cousson@ti.com>
 <20120106212230.GB7457@ponder.secretlab.ca>
Message-ID: <4F0AB9C8.10501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 1/6/2012 10:22 PM, Grant Likely wrote:
> On Tue, Dec 20, 2011 at 02:39:55PM +0100, Benoit Cousson wrote:

[...]

>> +	/*
>> +	 * XXX: Use a 0 irq_base for the moment since the legacy devices
>> +	 * created statically are expected a hwirq = irq mapping.
>> +	 * A proper offset will be added later, when IRQ resource creation
>> +	 * will be handled by DT.
>> +	 */
>> +	domain.irq_base = 0;
>> +	domain.nr_irq = nr_irqs;
>> +	domain.ops =&irq_domain_simple_ops;
>> +	irq_domain_add(&domain);
>
> The omap doesn't need anything special from irq_domain.  You can use
> irq_domain_add_simple().  A recent patch was posted that makes
> irq_domain_add_simple() accepts a nr_irqs parameter and returns the
> allocated irq domain.

Yes, I saw that, but in fact as discussed previously with Rob, even the 
irq_domain_add_simple should become useless when Rob's series to convert 
generic-chip to use irq_domain will be merged.

I have a patch ready for that, but like Nico for AT91, I decided to 
avoid that dependency for 3.3, since that series was not yet stable.

> However, that isn't enough reason for me to reject this patch if there
> is any opportunity to get it into v3.3 provided you promise to fix it
> up later.

Yes, I do :-)

> Acked-by: Grant Likely<grant.likely@secretlab.ca>

Thanks,
Benoit
