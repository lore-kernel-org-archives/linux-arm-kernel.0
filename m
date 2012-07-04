From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jul 2012 11:26:17 +0100
Subject: [PATCH] ARM: architected timers: Mark the clockevent with the
 C3_STOP feature
In-Reply-To: <1341395673-29660-1-git-send-email-santosh.shilimkar@ti.com>
References: <1341395673-29660-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20120704102617.GC16639@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 03:24:33PM +0530, Santosh Shilimkar wrote:
> ARM arch timers stop in low power state and hence can not wakeup CPUs in
> deeper idle states when used as cloc event devices. Marking these clock event
> devices with C3_STOP so that during lowpower states, the tick is managed by
> wakeup capable broadcast timer.

Will tells me that the arch timers don't stop in low power modes, they
just can't produce wakeup events.  Apparantly the spec says:

   The system counter must be implemented in an always-on power domain.
   Use of lower-frequency modes must not affect the implemented accuracy.

Are you sure your above description of the problem is correct?
