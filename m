From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Oct 2010 17:26:45 +0200
Subject: [patch 00/12] arm: raw_spinlock annotations
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20100217125328.791176536@linutronix.de>
	<20101019143717.GH11713@pengutronix.de>
Message-ID: <201010191726.45879.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 October 2010, Uwe Kleine-K?nig wrote:
> While cleaning up my repo I refound the patches and rebased them on top
> of today's Linus' tree and only needed to fix up the l2x0_lock patch as
> in the meantime a new usage hit mainline.

The patches all look harmless, but none of them has any information on
why the particular locks need to be raw_spin_lock. Ideally a raw spinlock
should be the absolute exception, and IMHO should have a comment in front
of it why it is special.

	Arnd
