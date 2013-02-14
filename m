From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Feb 2013 21:49:31 +0000
Subject: [patch 2/2] arm: Allow forced irq threading
In-Reply-To: <20130214205304.993009840@linutronix.de>
References: <20130214205204.109023136@linutronix.de>
 <20130214205304.993009840@linutronix.de>
Message-ID: <20130214214931.GK17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 08:53:53PM -0000, Thomas Gleixner wrote:
> All timer interrupts and the perf interrupt are marked NO_THREAD, so
> its safe to allow forced interrupt threading.

What effect does this have on IRQ latency, particularly on the slower CPUs?

If it adds to the IRQ latency, then it must be conditional; there are
platforms where IRQ latency is important for things like network devices
to keep up (particularly the SMC NICs).
