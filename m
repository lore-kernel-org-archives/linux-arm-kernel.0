From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jan 2010 13:55:53 +0000
Subject: [PATCH/RFC v1 0/2] Human readable performance event
	description in sysfs
In-Reply-To: <1263994779.4283.1057.camel@laptop>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop> <op.u6tslipz7p4s8u@pikus>
	<20100120133145.GE4089@wear.picochip.com>
	<1263994779.4283.1057.camel@laptop>
Message-ID: <20100120135553.GA22897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 02:39:39PM +0100, Peter Zijlstra wrote:
> Furthermore, /proc/cpuinfo should be enough information to come up with
> an arch specific set of events to be translated into raw.

Unfortunately, it isn't.  CPU identification has become a fairly murky
business on ARM that the information exported from /proc/cpuinfo can
no longer precisely identify the CPU itself.

For example, we just treat Cortex A8 and A9 as "ARMv7" because from the
kernel's point of view, they're the same.
