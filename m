From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 12 Jan 2010 12:29:00 -0500
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <20100112121723.GC27771@n2100.arm.linux.org.uk>
References: <20100110172825.GB8639@n2100.arm.linux.org.uk><87my0kmh4f.fsf@deeprootsystems.com>
	<20100112121723.GC27771@n2100.arm.linux.org.uk>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089AA3@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 12, 2010 5:17 AM, Russell King wrote,
> On Mon, Jan 11, 2010 at 02:06:08PM -0800, Kevin Hilman wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>>> Most machine classes want some way to register a block of clk_lookup
>>> structures, and most do it by implementing a clks_register() type
>>> function which walks an array, or by open-coding a loop.
>>>
>>> Consolidate all this into clkdev_add_table().
>>>
>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
>> 
>> Are you planning this for 2.6.33-rc?  or 2.6.34?
>
> I don't think it's -rc material (not a bug fix) so 2.6.34.

It's not a bug fix but due to how often people patch the various
clock sources it might be better to get this is soon so that merge
conflicts don't show up.

>
>> This should take care of davinci.  Tested on v2.6.33-rc3 + $SUBJECT patch.
>
> Shall I queue this for merging after my patch, or are there likely to
> be conflicts in this area?

BTW, arch/arm/mach-ep93xx/clock.c might need to be rebased due to you
applying 5875/1 and 5879/1 to your git-curr (ep93xx branch).

Regards,
Hartley
