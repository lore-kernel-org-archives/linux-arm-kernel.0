From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Jan 2016 16:23:13 +0000
Subject: [RFC PATCH v3] irqchip: Add support for Tango interrupt controller
In-Reply-To: <yw1xr3hcqlix.fsf@unicorn.mansr.com>
References: <569CE0F2.1060507@sigmadesigns.com>
 <569D0B80.1010908@sigmadesigns.com> <569D165E.4060004@sigmadesigns.com>
 <569FAFF5.4090909@arm.com> <yw1xr3hcqlix.fsf@unicorn.mansr.com>
Message-ID: <569FB471.8000909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/16 16:10, M?ns Rullg?rd wrote:
> Marc Zyngier <marc.zyngier@arm.com> writes:
> 
>>> +	if (of_property_read_u32(node, "reg", &ctl))
>>> +		panic("%s: failed to get reg base", node->name);
>>> +
>>> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
>>> +	chip->ctl = ctl;
>>> +	chip->base = base;
> 
> As I said before, this assumes the outer DT node uses a ranges
> property.  Normally reg properties work the same whether they specify an
> offset within an outer "ranges" or have a full address directly.  It
> would be easy enough to make this work with either, so I don't see any
> reason not to.

Yup, that is a good point. I guess Marc can address this in the next
round, since we need a DT binding anyway.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
