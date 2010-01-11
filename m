From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 11 Jan 2010 14:06:08 -0800
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <20100110172825.GB8639@n2100.arm.linux.org.uk> (Russell King's
	message of "Sun\, 10 Jan 2010 17\:28\:25 +0000")
References: <20100110172825.GB8639@n2100.arm.linux.org.uk>
Message-ID: <87my0kmh4f.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Most machine classes want some way to register a block of clk_lookup
> structures, and most do it by implementing a clks_register() type
> function which walks an array, or by open-coding a loop.
>
> Consolidate all this into clkdev_add_table().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>

Are you planning this for 2.6.33-rc?  or 2.6.34?

> ---
> This misses out Davinci, which needs cleaning up to remove its
> seemingly redundant wrapping of the clk_lookup structure.

This should take care of davinci.  Tested on v2.6.33-rc3 + $SUBJECT patch.
