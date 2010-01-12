From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 12:17:23 +0000
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <87my0kmh4f.fsf@deeprootsystems.com>
References: <20100110172825.GB8639@n2100.arm.linux.org.uk>
	<87my0kmh4f.fsf@deeprootsystems.com>
Message-ID: <20100112121723.GC27771@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 02:06:08PM -0800, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > Most machine classes want some way to register a block of clk_lookup
> > structures, and most do it by implementing a clks_register() type
> > function which walks an array, or by open-coding a loop.
> >
> > Consolidate all this into clkdev_add_table().
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Are you planning this for 2.6.33-rc?  or 2.6.34?

I don't think it's -rc material (not a bug fix) so 2.6.34.

> This should take care of davinci.  Tested on v2.6.33-rc3 + $SUBJECT patch.

Shall I queue this for merging after my patch, or are there likely to
be conflicts in this area?
