From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Apr 2012 18:04:43 +0100
Subject: [PATCH 2/2] clkdev: Implement managed clk_get()
In-Reply-To: <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120402170442.GF24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 12:32:40PM +0100, Mark Brown wrote:
> Allow clk API users to simplify their cleanup paths by providing a
> managed version of clk_get().
> 
> Due to the lack of a standard struct clk to look up the device from a
> managed clk_put() is not provided, it would be very unusual to use this
> function so it's not a big loss.

Err, why?  The contents of struct clk has nothing to do with clk_put().
You're doing something really wrong here.

Remember, there is not going to _ever_ be the situation where a struct clk
is specific to any particular struct device - it's a 1:N mapping between
clks and devices.

So, until you sort out your misunderstanding, NAK.
