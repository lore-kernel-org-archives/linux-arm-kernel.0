From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 9 Sep 2012 21:57:03 +0100
Subject: [PATCH] clk: Make the managed clk functions generically available
In-Reply-To: <1347202862-1617-1-git-send-email-lars@metafoo.de>
References: <1347202862-1617-1-git-send-email-lars@metafoo.de>
Message-ID: <20120909205703.GJ13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 09, 2012 at 05:01:02PM +0200, Lars-Peter Clausen wrote:
> The managed clk functions are currently only available when the generic clk
> lookup framework is build. But the managed clk functions are merely wrappers
> around clk_get and clk_put and do not depend on any specifics of the generic
> lookup functions and there are still quite a few custom implementations of the
> clk API. So make the managed functions available whenever the clk API is
> implemented.
> 
> The patch also removes the custom implementation of devm_clk_get for the
> coldfire platform.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Definitely-Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks for finally cooking up a patch for this.
