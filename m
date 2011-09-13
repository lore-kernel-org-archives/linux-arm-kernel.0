From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Sep 2011 23:37:47 +0100
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
	online/active
In-Reply-To: <alpine.LFD.2.02.1109132247490.2723@ionos>
References: <20110908215314.829452535@linutronix.de>
	<CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
	<20110913133258.GA6267@n2100.arm.linux.org.uk>
	<CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
	<20110913175312.GB6267@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1109132247490.2723@ionos>
Message-ID: <20110913223747.GA23109@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 10:48:48PM +0200, Thomas Gleixner wrote:
> The question is whether you really need to calibrate the delay for
> each core or if you simply can take the calibration of the first
> core. That would avoid enabling interrupts all the way.

That depends whether you require all cores in a SMP system to be built
the same way or not (and therefore to have the same performance.)  I'm
aware of at least one implementation where that isn't the case, and I
see no reason why that would not become more common.

In that case, we need the individual core delay calibration, and lock
delays to either cores or specific groups of cores, or use hardware
timers (if available, and with enough precision) for them.
