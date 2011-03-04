From: khilman@ti.com (Kevin Hilman)
Date: Fri, 04 Mar 2011 08:11:58 -0800
Subject: [PATCH 08/17] omap4: pm: Add GIC save/restore support
In-Reply-To: <20b497dc6e31dd5eb91b2a11002966c2@mail.gmail.com> (Santosh
	Shilimkar's message of "Fri, 4 Mar 2011 14:09:18 +0530")
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-9-git-send-email-santosh.shilimkar@ti.com>
	<8739n55f75.fsf@ti.com>
	<20b497dc6e31dd5eb91b2a11002966c2@mail.gmail.com>
Message-ID: <87ipvykgq9.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman at ti.com]
>> Sent: Thursday, March 03, 2011 4:00 AM
>> To: Santosh Shilimkar
>> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH 08/17] omap4: pm: Add GIC save/restore support
>>
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>
> [...]
>
>> > +	/*
>> > +	 * Find out how many interrupts are supported.
>> > +	 * OMAP4 supports max of 128 SPIs where as GIC can support
>> > +	 * up to 1020 interrupt sources.
>> > +	 */
>> > +	max_spi_reg = __raw_readl(gic_dist_base_addr + GIC_DIST_CTR) &
>> 0x1f;
>> > +	max_spi_irq = max_spi_reg * 32;
>>
>> Based on the spec, this should also be max'd at 1020 so you never
>> write the reserved values after 1020.
>>
>
> That's correct as per generic GIC specs. On OMAP4, the maximum IRQs
> already fused in "DIST_CTR"  bit-fields and fixed. Hence we don't
> need that additional comparison.
>

OK, clarifiying this in the comment above would avoid confusion for
anyone looking at this code in combination with the spec.

Thanks,

Kevin
