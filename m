From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 22 Apr 2016 09:02:54 +1000
Subject: [PATCH v2 10/11] arm: Add Aspeed machine
In-Reply-To: <1461277737.3135.14.camel@kernel.crashing.org>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-11-git-send-email-joel@jms.id.au>
 <6245614.OXDTEyrM2z@wuerfel> <1461277737.3135.14.camel@kernel.crashing.org>
Message-ID: <1461279774.3135.21.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-04-22 at 08:28 +1000, Benjamin Herrenschmidt wrote:
> It may or may not be already correct, you don't necessarily have a
> serial enabled bootloader or it might be using a UART driver that
> doesn't use the 'standard' divisors etc... This just sanitizes it.
> 
> This register contains misc controls. That specific bit controls a
> clock divisor by 13 from the main 24Mhz source, which provides a
> reasonably "standard" 1.84 Mhz input to the UARTs.

On a second thought ... if we chose to not support random crap vendor
uboots, we could make it a requirement that this register is already
set appropriately by the bootloader to match what's in the device-tree
I suppose...

That, along with a watchdog driver, would allow us to completely remove
that init code.

Joel, Jeremy, your call.

Cheers,
Ben.
