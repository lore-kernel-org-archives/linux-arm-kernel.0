From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Jun 2010 11:29:31 +0100
Subject: soft lockup - CPU#0 stuck for 61s! problem
In-Reply-To: <AANLkTin_iY-7nUwtf1q7Fz4qdnkA0BUktEC6WwCiQdOX@mail.gmail.com>
References: <AANLkTimqNv37LkJDyKJp9PnJapXH4naINhx-T2ysQi4D@mail.gmail.com>
	<20100628090036.GA28510@n2100.arm.linux.org.uk>
	<AANLkTin_iY-7nUwtf1q7Fz4qdnkA0BUktEC6WwCiQdOX@mail.gmail.com>
Message-ID: <20100628102931.GA30050@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 28, 2010 at 03:50:24PM +0530, Harishkumar V wrote:
> Will capture the further messages and mail u. Why an IRQ got struck, is
> their a way to handle this....

Normally, the kernel will disable the interrupt so the system can
continue to (mostly) function.

However, people like to return IRQ_HANDLED from interrupt handlers,
even when they've found nothing to do.  This prevents the kernel from
rescuing you from the stuck-IRQ problem.  Interrupt handlers are
supposed to return IRQ_HANDLED if they did something to handle the IRQ,
or IRQ_NONE if they found nothing to do.

I can't say much more than that - I've no idea what hardware you're
running the kernel on, and therefore I can't guess what IRQ92 might be.
