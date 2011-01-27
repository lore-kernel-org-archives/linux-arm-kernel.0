From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 27 Jan 2011 15:28:15 +0100
Subject: [PATCH 1/2] DMA: PL08x: fix infinite wait when terminating
	transfers
In-Reply-To: <20110127123253.GC25968@n2100.arm.linux.org.uk>
References: <20110127123253.GC25968@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimujX9WyoDagBkaWH9ywUr5g6_Kd-YMuUpdtCmt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> If we try to pause a channel when terminating a transfer, we could end
> up spinning for it to become inactive indefinitely, and can result in
> an uninterruptible wait requiring a reset to recover from.
>
> Terminating a transfer is supposed to take effect immediately, but may
> result in data loss.
>
> To make this clear, rename the function to pl08x_terminate_phy_chan().
> Also, make sure it is always consistently called - with the spinlock
> held and IRQs disabled, and ensure that the TC and ERR interrupt status
> is always cleared.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
