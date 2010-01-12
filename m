From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 12 Jan 2010 11:16:40 -0800
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <20100112121723.GC27771@n2100.arm.linux.org.uk> (Russell King's
	message of "Tue\, 12 Jan 2010 12\:17\:23 +0000")
References: <20100110172825.GB8639@n2100.arm.linux.org.uk>
	<87my0kmh4f.fsf@deeprootsystems.com>
	<20100112121723.GC27771@n2100.arm.linux.org.uk>
Message-ID: <8763779lrb.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Jan 11, 2010 at 02:06:08PM -0800, Kevin Hilman wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > Most machine classes want some way to register a block of clk_lookup
>> > structures, and most do it by implementing a clks_register() type
>> > function which walks an array, or by open-coding a loop.
>> >
>> > Consolidate all this into clkdev_add_table().
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> 
>> Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
>> 
>> Are you planning this for 2.6.33-rc?  or 2.6.34?
>
> I don't think it's -rc material (not a bug fix) so 2.6.34.

ok

>> This should take care of davinci.  Tested on v2.6.33-rc3 + $SUBJECT patch.
>
> Shall I queue this for merging after my patch, or are there likely to
> be conflicts in this area?

There are likely to be conflicts with other davinci patches, so since
it's independent from yours, I'll queue in my 2.6.34 queue along with
the rest of the davinci changes.

As long as your patch is included in linux-next, there shouldn't be
any problems keeping them separate.

Thanks,

Kevin
