From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jan 2010 13:59:50 +0000
Subject: [PATCH 00/35] davinci updates queued for 2.6.34
In-Reply-To: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20100110135950.GA8639@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2010 at 10:31:42AM -0800, Kevin Hilman wrote:
> Apologies for the large series, I've been meaning to send these in
> smaller batches, but hd lots to queue up from over the holidays.
> 
> Pending any review comments, these will be submitted to Linus during
> the next merge window.

Nothing specific on this series.

However, while looking at adding a standard clkdev_add_table() to replace
all those clks_register() implementations found in various machine files
(and open-coded versions of the same) I'm wondering why davinci wraps
the clk_lookup structure without adding anything to it.

Could davinci get rid of this seemingly useless wrapping (presumably
copied from OMAP) and so be able to switch over to use clkdev_add_table()
instead?
