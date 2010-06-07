From: mcuos.com@gmail.com (Wan ZongShun)
Date: Mon, 7 Jun 2010 22:12:45 +0800
Subject: [PATCH]ARM/footbridge: fix wrong parenthesis
In-Reply-To: <20100607140131.GA7220@n2100.arm.linux.org.uk>
References: <4C08C749.3050700@gmail.com>
	<20100607140131.GA7220@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin8Crq0F76TmXsLGsd9tXcYQKbDhxZgoDjvvazV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So should I send  a true one again or fix it by your self?

2010/6/7, Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Jun 04, 2010 at 05:28:41PM +0800, Wan ZongShun wrote:
>> There is a wrong redundant right parenthesis in this code.
>
> This patch is wrong.
>
>>  unsigned long __pfn_to_bus(unsigned long pfn)
>>  {
>> -	return __pfn_to_phys(pfn) + (fb_bus_sdram_offset() - PHYS_OFFSET));
>> +	return __pfn_to_phys(pfn + (fb_bus_sdram_offset() - PHYS_OFFSET));
>
> It makes no sense to add byte address offsets to a PFN.  The correct
> solution is to delete the right paren at the end of the line instead.
>


-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
