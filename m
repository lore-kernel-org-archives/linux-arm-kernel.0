From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 11 Jan 2010 07:31:57 -0800
Subject: [PATCH 00/35] davinci updates queued for 2.6.34
In-Reply-To: <20100110135950.GA8639@n2100.arm.linux.org.uk> (Russell King's
	message of "Sun\, 10 Jan 2010 13\:59\:50 +0000")
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<20100110135950.GA8639@n2100.arm.linux.org.uk>
Message-ID: <874omsr72q.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Jan 06, 2010 at 10:31:42AM -0800, Kevin Hilman wrote:
>> Apologies for the large series, I've been meaning to send these in
>> smaller batches, but hd lots to queue up from over the holidays.
>> 
>> Pending any review comments, these will be submitted to Linus during
>> the next merge window.
>
> Nothing specific on this series.
>
> However, while looking at adding a standard clkdev_add_table() to replace
> all those clks_register() implementations found in various machine files
> (and open-coded versions of the same) I'm wondering why davinci wraps
> the clk_lookup structure without adding anything to it.

It's no longer needed.  In initial implementation, I had some extra
fields like in OMAP, but then dropped them. 

> Could davinci get rid of this seemingly useless wrapping (presumably
> copied from OMAP) and so be able to switch over to use clkdev_add_table()
> instead?

Yes, I'll drop the wrapping.

Thanks for the reviews,

Kevin
