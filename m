From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jun 2010 21:05:50 +0100
Subject: soft lockup - CPU#0 stuck for 61s! problem
In-Reply-To: <AANLkTin-cXOIkMN9JXdPETP_aEjeCjF9qV2hIytc5xjU@mail.gmail.com>
References: <AANLkTimqNv37LkJDyKJp9PnJapXH4naINhx-T2ysQi4D@mail.gmail.com>
	<20100628090036.GA28510@n2100.arm.linux.org.uk>
	<AANLkTin_iY-7nUwtf1q7Fz4qdnkA0BUktEC6WwCiQdOX@mail.gmail.com>
	<20100628102931.GA30050@n2100.arm.linux.org.uk>
	<AANLkTin-cXOIkMN9JXdPETP_aEjeCjF9qV2hIytc5xjU@mail.gmail.com>
Message-ID: <20100629200550.GA14704@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 29, 2010 at 11:51:34AM +0530, Harishkumar V wrote:
> <3>BUG: soft lockup - CPU#0 stuck for 61s! [Xfbdev:723]
> BUG: soft lockup - CPU#0 stuck for 61s! [Xfbdev:723]
> Modules linked in:Modules linked in: cir_lin cir_lin

ARGH.  Disable the debugging printascii please.  It's *ONLY* there for
debugging the very early boot of the kernel, and once that's working
it should be disabled as soon as possible after that fact.

Leaving it on results in these messages becoming unreadable.

However, as I said subsequently, you need to investigate why your
IRQ92 handler is always returning IRQ_HANDLED.
