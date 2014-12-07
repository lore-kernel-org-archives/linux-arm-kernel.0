From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 7 Dec 2014 11:58:23 +0100
Subject: Do I need to invalidate caches before enabling (on ARMv7)?
In-Reply-To: <20141207100124.GT2129@pengutronix.de>
References: <20141204100357.GO2129@pengutronix.de>
 <20141206210031.GA1758@afzal-ThinkPad-R50e>
 <20141207100124.GT2129@pengutronix.de>
Message-ID: <20141207105823.GA21341@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> That would match http://www.arm.linux.org.uk/developer/booting.php which
> is good. I'd prefer if Linux handled stale data in the cache though for
> two reasons:
>  - Usually bootloaders are not perfect in adhering to requirements that
>    are not obvious from testing.
>  - Stale caches introduce problems that are hard to debug.

Can it handle stale data?

We had an issue with kirkwood boards with u-boot leaving the cache on
when jumping into Linux. This causes corruption in the decompressed
image as it was being decompressed. So by the time the kernel was
running, it was too late, bad things had already happened and death
was coming soon.

There is clearly a difference between leaving caches on, and turning
them off but not cleaning them. So maybe it is possible for the kernel
to handle this?

   Andrew
