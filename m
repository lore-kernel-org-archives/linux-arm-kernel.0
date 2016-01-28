From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 13:32:45 +0100
Subject: [PATCH] ARM: Use generic clkdev.h header
In-Reply-To: <1453932702-6930-1-git-send-email-sboyd@codeaurora.org>
References: <1453932702-6930-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <6141409.WI4q6BtOxa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 January 2016 14:11:42 Stephen Boyd wrote:
> Get rid of the clkdev.h file in the ARM port and use the generic
> one because we've gotten rid of all the machine specific
> mach/clkdev.h files.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 

Ah, nice! I had not even noticed it was the last one.

The file is still also referenced by arch/arm/plat-versatile/clock.c,
but we don't build that file any more and should remove it as well.

	Arnd
