From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Feb 2010 17:14:54 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <20100128112606.GC4175@wear.picochip.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<201001261847.44774.jpihet@mvista.com>
	<201001271840.47714.jpihet@mvista.com>
	<20100128112606.GC4175@wear.picochip.com>
Message-ID: <20100202171454.GA29701@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 11:26:06AM +0000, Jamie Iles wrote:
> This was my mistake and I don't think we should continue - we'd _probably_ be
> ok for sampling counters, but for the counting counters we could hit problems
> if the counters weren't being scheduled in and out. For example if someone did
> 'perf stat -a -e cycles -- sleep 1m' then the cycle counter would not need to
> be scheduled out, the counter could wrap a few times and we wouldn't know
> because we didn't get an interrupt.

Jamie,

Please let me know when these patches have stabilised.
