From: rth@redhat.com (Richard Henderson)
Date: Mon, 21 Dec 2009 11:30:43 -0800
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <20091217181718.GA4440@n2100.arm.linux.org.uk>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091217150120.GD24967@shareable.org>
	<4B2A65C6.7080009@caviumnetworks.com>
	<84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
	<20091217181718.GA4440@n2100.arm.linux.org.uk>
Message-ID: <4B2FCCE3.1090209@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2009 10:17 AM, Russell King - ARM Linux wrote:
> How is "size-optimal trap" defined?

E.g. Sparc and MIPS have "tcc" instructions that trap based on the
condition codes, and so we eliminate the branch.  That's the only
optimization we apply with __builtin_trap.

> Let me put it another way: I want this function to terminate with an
> explicit NULL pointer dereference in every case.

Then just use that.


r~
