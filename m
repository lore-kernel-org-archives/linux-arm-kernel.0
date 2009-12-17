From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2009 19:06:13 +0000
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <20091217183517.GC10707@synopsys.com>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091217150120.GD24967@shareable.org>
	<4B2A65C6.7080009@caviumnetworks.com>
	<84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
	<20091217181718.GA4440@n2100.arm.linux.org.uk>
	<20091217183517.GC10707@synopsys.com>
Message-ID: <20091217190613.GB4440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 10:35:17AM -0800, Joe Buck wrote:
> Besides, didn't I see a whole bunch of kernel security patches related
> to null pointer dereferences lately?  If page 0 can be mapped, you
> suddenly won't get your trap.

Page 0 can not be mapped on ARM kernels since the late 1990s, and this
protection is independent of the generic kernel.

Milage may vary on other architectures, but that's not a concern here.
