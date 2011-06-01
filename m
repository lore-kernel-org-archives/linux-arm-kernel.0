From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 10:22:29 +0100
Subject: [PATCH 3/3] mach-u300: cleanup clockevent code
In-Reply-To: <alpine.LFD.2.02.1106011027360.3078@ionos>
References: <1306876145-6778-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.02.1105312319530.3078@ionos>
	<BANLkTi=UyypKZUQOCCL-KWyAbMQBKY4ccg@mail.gmail.com>
	<alpine.LFD.2.02.1106011027360.3078@ionos>
Message-ID: <20110601092229.GE3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 10:34:46AM +0200, Thomas Gleixner wrote:
> But yeah, we can make it conditional for SMP and simply set
> cpumask_of(0) in the UP case.

Or cpumask_of(smp_processor_id()) which would also cover the non-CPU0 boot
cases (provided its called on the boot CPU.)
