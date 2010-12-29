From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 29 Dec 2010 01:50:37 +0100
Subject: [PATCH 5/6] ARM: PL011: Add support for transmit DMA
In-Reply-To: <E1PW4qN-0006GS-EM@rmk-PC.arm.linux.org.uk>
References: <20101224102359.GC20587@n2100.arm.linux.org.uk>
	<E1PW4qN-0006GS-EM@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTikkjd-j5MUcP254chPpWKpiQ_nh3ZjWz2OPEJVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> - remove RX DMA support. ?As PL011 doesn't give us receive timeout
> ?interrupts, we only get notified of received data when the RX DMA
> ?has completed. ?This rather sucks for interactive use of the TTY.

True for use with PL08x.

But for the systems U300 and Ux500 that have (only) burst
transfer support (such is the nature of their DMA engines) it will
likely work.

However it's OK for the time being, this is such a large step
forward for us anyway, and we can surely put in a new
patch for this only and discuss it... My idea would be not to
supply any RX channel playform data for hardware that cannot
handle this and in that case fall back to PIO for RX.

Yours,
Linus Walleij
