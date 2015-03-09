From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 16:23:28 +0000
Subject: [PATCH] mfd: mt6397: Use set_irq_flags only on ARM
In-Reply-To: <20150304075907.GN7865@pengutronix.de>
References: <1425453869-18482-1-git-send-email-s.hauer@pengutronix.de>
 <20150304075907.GN7865@pengutronix.de>
Message-ID: <20150309162328.GX8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 08:59:07AM +0100, Uwe Kleine-K?nig wrote:
> While this is what everyone does, I wonder why ARM is special here.
> Has this only historic reasons and needs refurbishment?

We have platforms where we need to ensure that certain interrupts can't
be requested.

Unfortunately, that was never properly dealt with when genirq came
along, and we're pretty much stuck with this situation: going through
and working out what the restrictions were is a much bigger problem
than it was when genirq first happened.  I don't see how we could
sanely fix this now.

What we should probably at least do is work out a way that we can kill
that ifdef, so we don't have the same hack appearing in many drivers.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
