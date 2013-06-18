From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Jun 2013 12:32:26 -0400
Subject: [PATCH 2/2] Watchdog: fix clearing of the watchdog interrupt
In-Reply-To: <E1Uoye0-0001Cw-Po@rmk-PC.arm.linux.org.uk>
References: <E1Uoye0-0001Cw-Po@rmk-PC.arm.linux.org.uk>
Message-ID: <20130618163226.GZ31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 05:20:32PM +0100, Russell King wrote:
> The bits in BRIDGE_CAUSE are documented as RW0C - read, write 0 to
> clear.  If we read the register, mask off the watchdog bit, and
> write it back, we're actually clearing every interrupt which wasn't
> pending at the time we read the register - and that is racy.
> 
> Fix this to only write ~WATCHDOG_BIT to the register, which means
> we write as zero only the watchdog bit.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/watchdog/orion_wdt.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
