From: khilman@ti.com (Kevin Hilman)
Date: Thu, 23 Jun 2011 12:05:28 -0700
Subject: [PATCH 25/25] ARM: pm: omap34xx: convert to generic
	suspend/resume support
In-Reply-To: <E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Wed, 22 Jun 2011 16:16:58 +0100")
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
	<E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
Message-ID: <874o3g9xmv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Convert sa11x0 to use the generic CPU suspend/resume support, rather
> than implementing its own version.  Tested on 3430 LDP.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I tested this on 3430/n900 and 3530/Overo and it worked fine for
retention, but not for off.

Testing with off-mode, I found the MULTI_CPU path to be broken in
cpu_suspend (jumping to zero.)  Rebuilding for only OMAP3, it worked
fine for full-chip retention in suspend and idle as well as full-chip
off in suspend and idle.

I'm digging into the MULTI_CPU path now.

Kevin
